import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_logo_mark.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/cases/presentation/simulation_conclusions_screen.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaseSimulationScreen extends StatefulWidget {
  const CaseSimulationScreen({
    super.key,
    required this.caseItem,
    required this.sessionId,
    required this.sessionRepository,
  });

  final generated.CaseResponse caseItem;
  final String sessionId;
  final SessionRepositoryContract sessionRepository;

  @override
  State<CaseSimulationScreen> createState() => _CaseSimulationScreenState();
}

class _CaseSimulationScreenState extends State<CaseSimulationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final InMemoryChatController _chatController;

  static const _doctorUserId = 'doctor';
  static const _patientUserId = 'patient';
  static const _systemUserId = 'system';

  bool _sending = false;
  String? _lastSentMessage;
  bool _loadingTests = false;
  String? _testsError;
  List<generated.AvailableTestItem> _availableTests = const [];
  generated.TestResultResponse? _lastTestResult;
  String? _orderingTestId;
  final Set<String> _selectedTests = <String>{};
  final Set<String> _pendingTests = <String>{};
  final List<generated.TestResultResponse> _completedResults =
      <generated.TestResultResponse>[];
  String _testsQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _chatController = InMemoryChatController();
    _restorePersistedMessages();
    _loadAvailableTests();
  }

  @override
  void dispose() {
    _chatController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleSend(String text) async {
    if (text.trim().isEmpty || _sending) return;
    text = text.trim();
    final outgoing = Message.text(
      id: _nextMessageId(),
      authorId: _doctorUserId,
      text: text,
      createdAt: DateTime.now(),
      sentAt: DateTime.now(),
    );
    await _chatController.insertMessage(outgoing);
    await _persistMessages();

    setState(() {
      _sending = true;
      _lastSentMessage = text;
    });

    try {
      final reply = await widget.sessionRepository.sendMessage(
        sessionId: widget.sessionId,
        message: text,
      );
      if (!mounted) return;
      await _chatController.insertMessage(
        Message.text(
          id: _nextMessageId(),
          authorId: _patientUserId,
          text: reply.response,
          createdAt: reply.loggedAt,
          sentAt: reply.loggedAt,
        ),
      );
      await _persistMessages();
    } catch (_) {
      if (mounted) {
        await _chatController.insertMessage(
          Message.system(
            id: _nextMessageId(),
            authorId: _systemUserId,
            text: 'Unable to reach patient. Please try again.',
            createdAt: DateTime.now(),
            metadata: {'isError': true, 'failedText': text},
          ),
        );
        await _persistMessages();
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  String _nextMessageId() =>
      '${DateTime.now().microsecondsSinceEpoch}-${_chatController.messages.length}';

  String get _historyStorageKey => 'chat-history-${widget.sessionId}';

  Future<void> _persistMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _chatController.messages
        .where((m) => m is TextMessage || m is SystemMessage)
        .map((m) {
      if (m is TextMessage) {
        return <String, dynamic>{
          'type': 'text',
          'id': m.id,
          'authorId': m.authorId,
          'text': m.text,
          'createdAt': m.createdAt?.millisecondsSinceEpoch,
          'sentAt': m.sentAt?.millisecondsSinceEpoch,
          'metadata': m.metadata,
        };
      }
      final s = m as SystemMessage;
      return <String, dynamic>{
        'type': 'system',
        'id': s.id,
        'authorId': s.authorId,
        'text': s.text,
        'createdAt': s.createdAt?.millisecondsSinceEpoch,
        'metadata': s.metadata,
      };
    }).toList(growable: false);
    await prefs.setString(_historyStorageKey, jsonEncode(data));
  }

  Future<void> _restorePersistedMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_historyStorageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return;
      final restored = <Message>[];
      for (final entry in decoded) {
        if (entry is! Map) continue;
        final map = Map<String, dynamic>.from(entry);
        final createdAtMs = map['createdAt'] as int?;
        final sentAtMs = map['sentAt'] as int?;
        final createdAt = createdAtMs == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(createdAtMs);
        final sentAt = sentAtMs == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(sentAtMs);
        final metadata = map['metadata'] is Map
            ? Map<String, dynamic>.from(map['metadata'] as Map)
            : null;
        if (map['type'] == 'system') {
          restored.add(
            Message.system(
              id: map['id'] as String,
              authorId: map['authorId'] as String,
              text: map['text'] as String,
              createdAt: createdAt,
              metadata: metadata,
            ),
          );
        } else {
          restored.add(
            Message.text(
              id: map['id'] as String,
              authorId: map['authorId'] as String,
              text: map['text'] as String,
              createdAt: createdAt,
              sentAt: sentAt,
              metadata: metadata,
            ),
          );
        }
      }
      if (restored.isNotEmpty && mounted) {
        await _chatController.setMessages(restored);
      }
    } catch (_) {
      // Ignore corrupted local history and start fresh.
    }
  }

  Future<void> _showMessageActions(Message message) async {
    final messageText = switch (message) {
      TextMessage m => m.text,
      SystemMessage m => m.text,
      _ => null,
    };
    final failedText = message.metadata?['failedText'] as String?;
    final isError = message.metadata?['isError'] == true;
    if (messageText == null && !(isError && failedText != null)) return;
    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (messageText != null)
              ListTile(
                leading: const Icon(Icons.copy_rounded),
                title: const Text('Copy message'),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: messageText));
                  if (context.mounted) Navigator.of(context).pop();
                  if (mounted) {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('Message copied')),
                    );
                  }
                },
              ),
            if (isError && failedText != null)
              ListTile(
                leading: const Icon(Icons.refresh_rounded),
                title: const Text('Retry send'),
                onTap: _sending
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        _handleSend(failedText);
                      },
              ),
            if (_lastSentMessage != null && message.authorId == _doctorUserId)
              ListTile(
                leading: const Icon(Icons.reply_rounded),
                title: const Text('Send again'),
                onTap: _sending
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        _handleSend(_lastSentMessage!);
                      },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadAvailableTests() async {
    setState(() {
      _loadingTests = true;
      _testsError = null;
    });
    try {
      final response = await widget.sessionRepository.getAvailableTests(
        sessionId: widget.sessionId,
      );
      if (!mounted) return;
      setState(() => _availableTests = response.tests.toList());
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _testsError = 'Unable to load tests.';
      });
    } finally {
      if (mounted) {
        setState(() => _loadingTests = false);
      }
    }
  }

  Future<void> _orderTest(String testName) async {
    if (_orderingTestId != null) return;
    setState(() {
      _orderingTestId = testName;
      _pendingTests.add(testName);
    });
    try {
      final result = await widget.sessionRepository.orderTest(
        sessionId: widget.sessionId,
        testId: testName,
      );
      if (!mounted) return;
      setState(() {
        _lastTestResult = result;
        _completedResults.removeWhere((r) => r.testName == result.testName);
        _completedResults.insert(0, result);
      });
      await _chatController.insertMessage(
        Message.system(
          id: _nextMessageId(),
          authorId: _systemUserId,
          text:
              'Test ordered: ${result.testName}\n\nResult: ${result.value}${result.unit == null ? '' : ' ${result.unit}'}${result.referenceRange == null ? '' : '\nReference: ${result.referenceRange}'}',
          createdAt: DateTime.now(),
        ),
      );
      await _persistMessages();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not order this test right now.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _orderingTestId = null;
          _pendingTests.remove(testName);
          _selectedTests.remove(testName);
        });
      }
    }
  }

  Future<void> _orderSelectedTests() async {
    final queue = _selectedTests.toList(growable: false);
    for (final test in queue) {
      await _orderTest(test);
    }
  }

  void _openFinishCaseFlow() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SimulationConclusionsScreen(
          caseItem: widget.caseItem,
          sessionId: widget.sessionId,
          sessionRepository: widget.sessionRepository,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.caseItem;
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openFinishCaseFlow,
        backgroundColor: AppColors.successTeal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.check_circle_outline_rounded),
        label: Text(
          'Finish case',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          _SimulationHeader(
            caseItem: c,
            sessionId: widget.sessionId,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 960;
                final sidebar = _SimulationSidebar(
                  tabController: _tabController,
                  caseItem: c,
                  loadingTests: _loadingTests,
                  testsError: _testsError,
                  availableTests: _availableTests,
                  lastResult: _lastTestResult,
                  orderingTestId: _orderingTestId,
                  selectedTests: _selectedTests,
                  pendingTests: _pendingTests,
                  completedResults: _completedResults,
                  testsQuery: _testsQuery,
                  onQueryChanged: (v) => setState(() => _testsQuery = v),
                  onToggleTestSelection: (testName) {
                    setState(() {
                      if (_selectedTests.contains(testName)) {
                        _selectedTests.remove(testName);
                      } else {
                        _selectedTests.add(testName);
                      }
                    });
                  },
                  onOrderSelectedTests: _orderSelectedTests,
                  onRetryLoadTests: _loadAvailableTests,
                  onOrderTest: _orderTest,
                );
                final chat = _buildChat();
                if (wide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 3, child: chat),
                      SizedBox(width: 320, child: sidebar),
                    ],
                  );
                }
                return Column(
                  children: [
                    Expanded(child: chat),
                    SizedBox(height: 260, child: sidebar),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChat() {
    return Stack(
      children: [
        Chat(
          currentUserId: _doctorUserId,
          chatController: _chatController,
          onMessageSend: _handleSend,
          builders: Builders(
            textMessageBuilder: _buildMarkdownTextMessage,
            systemMessageBuilder: _buildMarkdownSystemMessage,
          ),
          onMessageLongPress: (context, message,
              {required index, required details}) {
            _showMessageActions(message);
          },
          onMessageSecondaryTap: (context, message, {required index, details}) {
            _showMessageActions(message);
          },
          resolveUser: (id) async => User(id: id, name: _displayName(id)),
          theme: ChatTheme.fromThemeData(
            Theme.of(context).copyWith(
              textTheme:
                  GoogleFonts.interTextTheme(Theme.of(context).textTheme),
            ),
          ),
        ),
        if (_sending)
          Positioned(
            right: 16,
            bottom: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 8),
                    Text('Patient is thinking...'),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _displayName(String id) {
    if (id == _doctorUserId) return 'You (Doctor)';
    if (id == _systemUserId) return 'System';
    return 'Virtual Patient';
  }

  Widget _buildMarkdownTextMessage(
    BuildContext context,
    TextMessage message,
    int index, {
    required bool isSentByMe,
    MessageGroupStatus? groupStatus,
  }) {
    final isDoctorMessage = message.authorId == _doctorUserId;
    final bubbleColor =
        isDoctorMessage ? AppColors.doctorBubbleBg : AppColors.patientBubbleBg;
    final textColor = isDoctorMessage ? Colors.white : AppColors.primaryText;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(12),
        border:
            isDoctorMessage ? null : Border.all(color: AppColors.borderSubtle),
      ),
      child: MarkdownBody(
        data: message.text,
        selectable: true,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          p: GoogleFonts.inter(
            fontSize: 14,
            height: 1.4,
            color: textColor,
          ),
          code: GoogleFonts.robotoMono(
            fontSize: 12,
            color: textColor,
          ),
          listBullet: GoogleFonts.inter(
            fontSize: 14,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildMarkdownSystemMessage(
    BuildContext context,
    SystemMessage message,
    int index, {
    required bool isSentByMe,
    MessageGroupStatus? groupStatus,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.dangerSoftBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: MarkdownBody(
        data: message.text,
        selectable: true,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          p: GoogleFonts.inter(
            fontSize: 14,
            height: 1.4,
            color: AppColors.danger,
          ),
        ),
      ),
    );
  }
}

class _SimulationHeader extends StatelessWidget {
  const _SimulationHeader({
    required this.caseItem,
    required this.sessionId,
  });

  final generated.CaseResponse caseItem;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final sexAbb = caseItem.sex.isNotEmpty ? caseItem.sex[0].toUpperCase() : '';
    final shortSession =
        sessionId.length > 8 ? sessionId.substring(0, 8) : sessionId;
    return Material(
      color: AppColors.surface,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              color: AppColors.primaryText,
            ),
            const AppLogoMark(
              compact: true,
              subtitle: 'Medical Training Simulation',
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${caseItem.caseId} · ${caseItem.title}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Text(
                    '${caseItem.age}$sexAbb · Session $shortSession…',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _SimulationSidebar extends StatelessWidget {
  const _SimulationSidebar({
    required this.tabController,
    required this.caseItem,
    required this.loadingTests,
    required this.testsError,
    required this.availableTests,
    required this.lastResult,
    required this.orderingTestId,
    required this.selectedTests,
    required this.pendingTests,
    required this.completedResults,
    required this.testsQuery,
    required this.onQueryChanged,
    required this.onToggleTestSelection,
    required this.onOrderSelectedTests,
    required this.onRetryLoadTests,
    required this.onOrderTest,
  });

  final TabController tabController;
  final generated.CaseResponse caseItem;
  final bool loadingTests;
  final String? testsError;
  final List<generated.AvailableTestItem> availableTests;
  final generated.TestResultResponse? lastResult;
  final String? orderingTestId;
  final Set<String> selectedTests;
  final Set<String> pendingTests;
  final List<generated.TestResultResponse> completedResults;
  final String testsQuery;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onToggleTestSelection;
  final Future<void> Function() onOrderSelectedTests;
  final VoidCallback onRetryLoadTests;
  final Future<void> Function(String testName) onOrderTest;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: AppColors.borderSubtle)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              controller: tabController,
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: AppColors.secondaryText,
              indicatorColor: AppColors.primaryBlue,
              labelStyle:
                  GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
              tabs: const [
                Tab(text: 'Patient Summary'),
                Tab(text: 'Orders'),
                Tab(text: 'Lab Reports'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _SummaryTab(caseItem: caseItem),
                  _OrdersTab(
                    loadingTests: loadingTests,
                    testsError: testsError,
                    availableTests: availableTests,
                    lastResult: lastResult,
                    orderingTestId: orderingTestId,
                    selectedTests: selectedTests,
                    pendingTests: pendingTests,
                    completedResults: completedResults,
                    testsQuery: testsQuery,
                    onQueryChanged: onQueryChanged,
                    onToggleTestSelection: onToggleTestSelection,
                    onOrderSelectedTests: onOrderSelectedTests,
                    onRetryLoadTests: onRetryLoadTests,
                    onOrderTest: onOrderTest,
                  ),
                  _LabReportsTab(
                    pendingTests: pendingTests,
                    completedResults: completedResults,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTab extends StatelessWidget {
  const _SummaryTab({required this.caseItem});

  final generated.CaseResponse caseItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Chief complaint',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          caseItem.chiefComplaint,
          style:
              GoogleFonts.inter(fontSize: 13, color: AppColors.secondaryText),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.warningBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.warningBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: AppColors.danger, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Review red flags and key history points in the full case definition.',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.primaryText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: AppColors.secondaryText),
        ),
      ),
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab({
    required this.loadingTests,
    required this.testsError,
    required this.availableTests,
    required this.lastResult,
    required this.orderingTestId,
    required this.selectedTests,
    required this.pendingTests,
    required this.completedResults,
    required this.testsQuery,
    required this.onQueryChanged,
    required this.onToggleTestSelection,
    required this.onOrderSelectedTests,
    required this.onRetryLoadTests,
    required this.onOrderTest,
  });

  final bool loadingTests;
  final String? testsError;
  final List<generated.AvailableTestItem> availableTests;
  final generated.TestResultResponse? lastResult;
  final String? orderingTestId;
  final Set<String> selectedTests;
  final Set<String> pendingTests;
  final List<generated.TestResultResponse> completedResults;
  final String testsQuery;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onToggleTestSelection;
  final Future<void> Function() onOrderSelectedTests;
  final VoidCallback onRetryLoadTests;
  final Future<void> Function(String testName) onOrderTest;

  @override
  Widget build(BuildContext context) {
    if (loadingTests) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    if (testsError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(testsError!,
                  style: GoogleFonts.inter(color: AppColors.danger)),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: onRetryLoadTests,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    final q = testsQuery.trim().toLowerCase();
    final visibleTests = availableTests.where((t) {
      if (q.isEmpty) return true;
      return t.testName.toLowerCase().contains(q) ||
          t.category.toLowerCase().contains(q);
    }).toList(growable: false);
    final grouped = <String, List<generated.AvailableTestItem>>{};
    for (final test in visibleTests) {
      grouped.putIfAbsent(test.category, () => <generated.AvailableTestItem>[]);
      grouped[test.category]!.add(test);
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          'Instrumental tests',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search tests',
            prefixIcon: Icon(Icons.search_rounded),
            isDense: true,
          ),
          onChanged: onQueryChanged,
        ),
        const SizedBox(height: 8),
        if (visibleTests.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'No tests match your query.',
              style: GoogleFonts.inter(color: AppColors.secondaryText),
            ),
          ),
        for (final category in grouped.keys.toList()..sort()) ...[
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 4),
            child: Text(
              category.replaceAll('_', ' ').toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryText,
              ),
            ),
          ),
          ...grouped[category]!.map(
            (t) => Card(
              margin: const EdgeInsets.only(bottom: 6),
              child: ListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                title: Text(t.testName, style: GoogleFonts.inter(fontSize: 12)),
                subtitle: Text(
                  pendingTests.contains(t.testName)
                      ? 'Pending'
                      : completedResults.any((r) => r.testName == t.testName)
                          ? 'Completed'
                          : 'Not ordered',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: pendingTests.contains(t.testName)
                        ? AppColors.primaryBlue
                        : AppColors.secondaryText,
                  ),
                ),
                trailing: Wrap(
                  spacing: 6,
                  children: [
                    Checkbox(
                      value: selectedTests.contains(t.testName),
                      onChanged: pendingTests.contains(t.testName)
                          ? null
                          : (_) => onToggleTestSelection(t.testName),
                    ),
                    OutlinedButton(
                      onPressed: orderingTestId == null
                          ? () => onOrderTest(t.testName)
                          : null,
                      child: orderingTestId == t.testName
                          ? const SizedBox(
                              height: 12,
                              width: 12,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Order'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 6),
        FilledButton.icon(
          onPressed: selectedTests.isEmpty || orderingTestId != null
              ? null
              : onOrderSelectedTests,
          icon: const Icon(Icons.shopping_cart_checkout_rounded, size: 16),
          label: Text(
            'Order selected (${selectedTests.length})',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
        if (lastResult != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Text(
              'Latest: ${lastResult!.testName}\n${lastResult!.value}${lastResult!.unit == null ? '' : ' ${lastResult!.unit}'}${lastResult!.referenceRange == null ? '' : '\nRef: ${lastResult!.referenceRange}'}',
              style:
                  GoogleFonts.inter(fontSize: 12, color: AppColors.primaryText),
            ),
          ),
        ],
      ],
    );
  }
}

class _LabReportsTab extends StatelessWidget {
  const _LabReportsTab({
    required this.pendingTests,
    required this.completedResults,
  });

  final Set<String> pendingTests;
  final List<generated.TestResultResponse> completedResults;

  @override
  Widget build(BuildContext context) {
    if (pendingTests.isEmpty && completedResults.isEmpty) {
      return const _PlaceholderTab(text: 'Order tests to see lab reports.');
    }
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        if (pendingTests.isNotEmpty) ...[
          Text(
            'Pending',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 8),
          ...pendingTests.map(
            (name) => ListTile(
              dense: true,
              leading: const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              title: Text(name, style: GoogleFonts.inter(fontSize: 12)),
              subtitle: Text(
                'Ordering...',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.secondaryText,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (completedResults.isNotEmpty) ...[
          Text(
            'Completed',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 8),
          ...completedResults.map((result) {
            final isAbnormal = _isAbnormalResult(result);
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    isAbnormal ? AppColors.warningBg : AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isAbnormal
                      ? AppColors.warningBorder
                      : AppColors.borderSubtle,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.testName,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${result.value}${result.unit == null ? '' : ' ${result.unit}'}',
                    style: GoogleFonts.inter(fontSize: 12),
                  ),
                  if (result.referenceRange != null)
                    Text(
                      'Reference: ${result.referenceRange}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    isAbnormal ? 'Abnormal' : 'Normal',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color:
                          isAbnormal ? AppColors.danger : AppColors.successTeal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}

bool _isAbnormalResult(generated.TestResultResponse result) {
  if (result.isNormalDefault) return false;
  final reference = result.referenceRange;
  final numericValue = double.tryParse(result.value.trim());
  if (reference != null && numericValue != null) {
    final rangeParts = reference.split('-');
    if (rangeParts.length == 2) {
      final low = double.tryParse(rangeParts[0].trim());
      final high = double.tryParse(rangeParts[1].trim());
      if (low != null && high != null) {
        return numericValue < low || numericValue > high;
      }
    }
  }
  final v = result.value.toLowerCase();
  return v.contains('abnormal') ||
      v.contains('elevation') ||
      v.contains('st elevation');
}

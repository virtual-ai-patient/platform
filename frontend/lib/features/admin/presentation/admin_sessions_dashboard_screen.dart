import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_logo_mark.dart';
import 'package:frontend/domains/admin/admin_repository.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

class AdminSessionsDashboardScreen extends StatefulWidget {
  const AdminSessionsDashboardScreen({
    super.key,
    required this.session,
    required this.adminRepository,
    required this.authRepository,
    required this.buildLoginPage,
  });

  final AuthSession session;
  final AdminRepositoryContract adminRepository;
  final AuthRepositoryContract authRepository;
  final Widget Function() buildLoginPage;

  @override
  State<AdminSessionsDashboardScreen> createState() =>
      _AdminSessionsDashboardScreenState();
}

class _AdminSessionsDashboardScreenState
    extends State<AdminSessionsDashboardScreen> {
  final _studentCtrl = TextEditingController();
  final _caseCtrl = TextEditingController();
  int _page = 1;
  final int _pageSize = 20;
  DateTime? _onDate;

  bool _loading = false;
  String? _listError;
  generated.SessionListResponse? _list;
  generated.SessionSummary? _selected;
  bool _loadingDetail = false;
  String? _detailError;
  generated.SessionDetailResponse? _detail;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  @override
  void dispose() {
    _studentCtrl.dispose();
    _caseCtrl.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    await widget.authRepository.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => widget.buildLoginPage()),
      (_) => false,
    );
  }

  Future<void> _loadSessions() async {
    setState(() {
      _loading = true;
      _listError = null;
    });
    try {
      final list = await widget.adminRepository.listSessions(
        page: _page,
        pageSize: _pageSize,
        student: _studentCtrl.text,
        caseId: _caseCtrl.text,
        onDate: _onDate,
      );
      if (!mounted) return;
      setState(() {
        _list = list;
        if (list.sessions.isNotEmpty) {
          final selectedId = _selected?.sessionId;
          generated.SessionSummary? matched;
          if (selectedId != null) {
            for (final session in list.sessions) {
              if (session.sessionId == selectedId) {
                matched = session;
                break;
              }
            }
          }
          _selected = matched ?? list.sessions.first;
        } else {
          _selected = null;
          _detail = null;
        }
      });
      if (_selected != null) {
        await _loadDetail(_selected!.sessionId);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _listError = 'Could not load sessions: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadDetail(String sessionId) async {
    setState(() {
      _loadingDetail = true;
      _detailError = null;
    });
    try {
      final detail = await widget.adminRepository.getSessionDetail(
        sessionId: sessionId,
      );
      if (!mounted) return;
      setState(() => _detail = detail);
    } catch (e) {
      if (!mounted) return;
      setState(() => _detailError = 'Could not load detail: $e');
    } finally {
      if (mounted) setState(() => _loadingDetail = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.session.user.role.toLowerCase();
    if (role != 'admin' && role != 'educator') {
      return Scaffold(
        appBar: AppBar(title: const Text('Student Sessions')),
        body: const Center(child: Text('Access denied')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      appBar: AppBar(
        title: const AppLogoMark(
          compact: true,
          subtitle: 'Student Dialogue & Action Trace',
        ),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loading ? null : _loadSessions,
            icon: const Icon(Icons.refresh_rounded),
          ),
          TextButton(
            onPressed: _signOut,
            child: Text(
              'Sign out',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 420,
                  child: _buildSessionListPane(),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: _buildDetailPane()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _studentCtrl,
              decoration: const InputDecoration(
                labelText: 'Student username',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _caseCtrl,
              decoration: const InputDecoration(
                labelText: 'Case ID',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton.icon(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: _onDate ?? DateTime.now(),
              );
              if (picked != null) {
                setState(() => _onDate = picked);
              }
            },
            icon: const Icon(Icons.calendar_month_rounded),
            label: Text(
              _onDate == null
                  ? 'Date'
                  : '${_onDate!.year}-${_onDate!.month.toString().padLeft(2, '0')}-${_onDate!.day.toString().padLeft(2, '0')}',
            ),
          ),
          if (_onDate != null)
            IconButton(
              onPressed: () => setState(() => _onDate = null),
              icon: const Icon(Icons.clear_rounded),
              tooltip: 'Clear date filter',
            ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () {
              setState(() => _page = 1);
              _loadSessions();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionListPane() {
    if (_loading && _list == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_listError != null && _list == null) {
      return Center(child: Text(_listError!));
    }
    final sessions =
        _list?.sessions.toList() ?? const <generated.SessionSummary>[];
    final total = _list?.total ?? 0;
    final totalPages = (total / _pageSize).ceil().clamp(1, 9999);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                'Sessions ($total)',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                onPressed: _page > 1
                    ? () {
                        setState(() => _page -= 1);
                        _loadSessions();
                      }
                    : null,
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Text('$_page/$totalPages',
                  style: GoogleFonts.inter(fontSize: 12)),
              IconButton(
                onPressed: _page < totalPages
                    ? () {
                        setState(() => _page += 1);
                        _loadSessions();
                      }
                    : null,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: sessions.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final s = sessions[index];
              final selected = _selected?.sessionId == s.sessionId;
              return ListTile(
                selected: selected,
                title: Text(
                  '${s.caseId} · ${s.caseTitle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${s.studentUsername} · ${s.createdAt.toLocal().toIso8601String()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  setState(() => _selected = s);
                  _loadDetail(s.sessionId);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailPane() {
    if (_selected == null) {
      return const Center(child: Text('Select a session'));
    }
    if (_loadingDetail && _detail == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_detailError != null && _detail == null) {
      return Center(child: Text(_detailError!));
    }
    final detail = _detail;
    if (detail == null) return const SizedBox.shrink();

    final chatEntries = detail.actionLog
        .where((e) => e.role == 'user' || e.role == 'assistant')
        .toList(growable: false);
    final timelineEntries = detail.actionLog.toList(growable: false);

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _paneHeader('Dialogue'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: chatEntries.length,
                  itemBuilder: (context, index) {
                    final e = chatEntries[index];
                    final fromUser = e.role == 'user';
                    return Align(
                      alignment: fromUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(10),
                        constraints: const BoxConstraints(maxWidth: 460),
                        decoration: BoxDecoration(
                          color: fromUser
                              ? AppColors.doctorBubbleBg
                              : AppColors.patientBubbleBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          e.content,
                          style: GoogleFonts.inter(
                            color:
                                fromUser ? Colors.white : AppColors.primaryText,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: Column(
            children: [
              _paneHeader('Action Timeline'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: timelineEntries.length,
                  itemBuilder: (context, index) {
                    final e = timelineEntries[index];
                    final tag = _actionTag(e);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.borderSubtle),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                e.role,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: tag.color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  tag.label,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: tag.color,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                e.createdAt.toLocal().toIso8601String(),
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _displayContent(e),
                            style: GoogleFonts.inter(fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paneHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Text(
        title,
        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
    );
  }
}

({String label, Color color}) _actionTag(generated.ActionLogEntry entry) {
  final role = entry.role.toLowerCase();
  if (role == 'user') {
    return (label: 'Student message', color: AppColors.primaryBlue);
  }
  if (role == 'assistant') {
    return (label: 'Patient reply', color: AppColors.successTeal);
  }
  if (role == 'system') {
    if (entry.content.startsWith('TEST_ORDERED:')) {
      return (label: 'Test ordered', color: AppColors.warningBorder);
    }
    return (label: 'System event', color: AppColors.secondaryText);
  }
  return (label: 'Action', color: AppColors.primaryBlue);
}

String _displayContent(generated.ActionLogEntry entry) {
  if (entry.role.toLowerCase() == 'system' &&
      entry.content.startsWith('TEST_ORDERED:')) {
    final testId = entry.content.substring('TEST_ORDERED:'.length).trim();
    return testId.isEmpty ? 'Test ordered' : 'Test ordered: $testId';
  }
  return entry.content;
}

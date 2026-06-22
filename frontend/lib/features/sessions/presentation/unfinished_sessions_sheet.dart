import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/evaluation/communication_repository.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/sessions/presentation/resume_session_flow.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

enum _SheetPhase { loading, ready, error, forbidden }

/// Shows active sessions after login when the learner has unfinished work.
Future<void> showUnfinishedSessionsSheet({
  required BuildContext context,
  required SessionRepositoryContract sessionRepository,
  required EvaluationRepositoryContract evaluationRepository,
  required CommunicationRepositoryContract communicationRepository,
}) async {
  final maxHeight = MediaQuery.sizeOf(context).height * 0.62;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: AppColors.surface,
    constraints: BoxConstraints(maxHeight: maxHeight),
    builder: (ctx) => _UnfinishedSessionsBody(
      sessionRepository: sessionRepository,
      evaluationRepository: evaluationRepository,
      communicationRepository: communicationRepository,
    ),
  );
}

class _UnfinishedSessionsBody extends StatefulWidget {
  const _UnfinishedSessionsBody({
    required this.sessionRepository,
    required this.evaluationRepository,
    required this.communicationRepository,
  });

  final SessionRepositoryContract sessionRepository;
  final EvaluationRepositoryContract evaluationRepository;
  final CommunicationRepositoryContract communicationRepository;

  @override
  State<_UnfinishedSessionsBody> createState() =>
      _UnfinishedSessionsBodyState();
}

class _UnfinishedSessionsBodyState extends State<_UnfinishedSessionsBody> {
  _SheetPhase _phase = _SheetPhase.loading;
  List<generated.ActiveSessionItem> _items = [];
  String? _errorDetail;
  final Set<String> _busySessionIds = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _phase = _SheetPhase.loading;
      _errorDetail = null;
    });
    try {
      final items = await widget.sessionRepository.listActive();
      if (!mounted) return;
      if (items.isEmpty) {
        Navigator.of(context).pop();
        return;
      }
      setState(() {
        _items = items;
        _phase = _SheetPhase.ready;
      });
    } on DioException catch (e) {
      if (!mounted) return;
      final code = e.response?.statusCode;
      setState(() {
        _errorDetail = _detailFromDio(e);
        _phase = code == 403 ? _SheetPhase.forbidden : _SheetPhase.error;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorDetail = e.toString();
        _phase = _SheetPhase.error;
      });
    }
  }

  String? _detailFromDio(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['detail'] != null) {
      return data['detail'].toString();
    }
    return e.message;
  }

  Future<void> _onResume(generated.ActiveSessionItem item) async {
    if (_busySessionIds.contains(item.sessionId)) return;
    setState(() => _busySessionIds.add(item.sessionId));
    final rootContext = context;
    await resumeSessionAndNavigate(
      context: rootContext,
      sessionId: item.sessionId,
      sessionRepository: widget.sessionRepository,
      evaluationRepository: widget.evaluationRepository,
      communicationRepository: widget.communicationRepository,
    );
    if (mounted) {
      setState(() => _busySessionIds.remove(item.sessionId));
      if (_items.length <= 1 && rootContext.mounted) {
        Navigator.of(rootContext).pop();
      }
    }
  }

  Future<void> _onAbandon(generated.ActiveSessionItem item) async {
    if (_busySessionIds.contains(item.sessionId)) return;
    setState(() => _busySessionIds.add(item.sessionId));
    try {
      await widget.sessionRepository.abandonSession(sessionId: item.sessionId);
      if (!mounted) return;
      setState(() {
        _items = _items.where((i) => i.sessionId != item.sessionId).toList();
        _busySessionIds.remove(item.sessionId);
      });
      if (_items.isEmpty && mounted) {
        Navigator.of(context).pop();
      }
    } on DioException catch (e) {
      if (!mounted) return;
      if (e.response?.statusCode == 409) {
        setState(() {
          _items = _items.where((i) => i.sessionId != item.sessionId).toList();
          _busySessionIds.remove(item.sessionId);
        });
        if (_items.isEmpty && mounted) Navigator.of(context).pop();
        return;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _detailFromDio(e) ?? 'Could not abandon session.',
              style: GoogleFonts.inter(),
            ),
          ),
        );
        setState(() => _busySessionIds.remove(item.sessionId));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not abandon session.',
              style: GoogleFonts.inter(),
            ),
          ),
        );
        setState(() => _busySessionIds.remove(item.sessionId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom + 12,
        ),
        child: switch (_phase) {
          _SheetPhase.loading => _LoadingPanel(),
          _SheetPhase.forbidden => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ErrorPanel(
                title: 'Access denied',
                message: 'Could not load your unfinished sessions.',
                detail: _errorDetail,
                onRetry: _load,
              ),
            ),
          _SheetPhase.error => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ErrorPanel(
                title: 'Could not load sessions',
                message: 'Check your connection and try again.',
                detail: _errorDetail,
                onRetry: _load,
              ),
            ),
          _SheetPhase.ready => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SheetHeader(count: _items.length),
                Flexible(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return _UnfinishedSessionCard(
                        item: item,
                        busy: _busySessionIds.contains(item.sessionId),
                        onResume: () => _onResume(item),
                        onAbandon: () => _onAbandon(item),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Browse cases instead',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        },
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.heroTint, AppColors.heroTintEnd],
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.borderSubtle),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.brandTeal.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.play_circle_outline_rounded,
              color: AppColors.brandTeal,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Pick up where you left off',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.brandTeal,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$count active',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'These simulations are saved on the server. Resume to continue or abandon to start fresh.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UnfinishedSessionCard extends StatelessWidget {
  const _UnfinishedSessionCard({
    required this.item,
    required this.busy,
    required this.onResume,
    required this.onAbandon,
  });

  final generated.ActiveSessionItem item;
  final bool busy;
  final VoidCallback onResume;
  final VoidCallback onAbandon;

  String get _stageLabel {
    final summary = item.progressSummary;
    if (summary.hasConclusions) return 'Wrapping up';
    if (summary.turnCount <= 2) return 'Getting started';
    if (summary.turnCount <= 6) return 'History & exam';
    return 'Diagnostics in progress';
  }

  double get _progressValue {
    final turns = item.progressSummary.turnCount;
    if (item.progressSummary.hasConclusions) return 0.92;
    return (turns / 10).clamp(0.12, 0.85);
  }

  @override
  Widget build(BuildContext context) {
    final summary = item.progressSummary;
    final title = item.caseTitle.isEmpty ? item.caseId : item.caseTitle;

    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: busy ? null : onResume,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 5,
                color: summary.hasConclusions
                    ? AppColors.successTeal
                    : AppColors.brandTeal,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          _StatusChip(
                            label: 'In progress',
                            color: AppColors.brandTeal,
                            background: AppColors.brandTeal.withValues(
                              alpha: 0.12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: AppColors.tertiaryText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _relativeLastActivity(item.lastActivityAt),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.tertiaryText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: LinearProgressIndicator(
                                value: _progressValue,
                                minHeight: 6,
                                backgroundColor: AppColors.surfaceMuted,
                                color: summary.hasConclusions
                                    ? AppColors.successTeal
                                    : AppColors.primaryBlue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _stageLabel,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _MetaChip(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: '${summary.turnCount} turns',
                          ),
                          if (summary.hasConclusions)
                            _MetaChip(
                              icon: Icons.edit_note_rounded,
                              label: 'Conclusions started',
                              emphasized: true,
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          TextButton(
                            onPressed: busy ? null : onAbandon,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.danger,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Abandon',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (busy)
                            const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            FilledButton.icon(
                              onPressed: onResume,
                              icon: const Icon(Icons.play_arrow_rounded,
                                  size: 18),
                              label: Text(
                                'Resume',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
    required this.background,
  });

  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    this.emphasized = false,
  });

  final IconData icon;
  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final fg = emphasized ? AppColors.primaryBlue : AppColors.secondaryText;
    final bg =
        emphasized ? AppColors.primaryBlueLight : AppColors.chipBackground;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: emphasized
              ? AppColors.primaryBlue.withValues(alpha: 0.2)
              : AppColors.chipBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

String _relativeLastActivity(DateTime dt) {
  final local = dt.toLocal();
  final now = DateTime.now();
  final diff = now.difference(local);
  if (diff.inMinutes < 1) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
}

class _LoadingPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Checking for unfinished sessions…',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({
    required this.title,
    required this.message,
    this.detail,
    required this.onRetry,
  });

  final String title;
  final String message;
  final String? detail;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(message, style: GoogleFonts.inter(fontSize: 14)),
          if (detail != null && detail!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              detail!,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.secondaryText,
              ),
            ),
          ],
          const SizedBox(height: 16),
          FilledButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

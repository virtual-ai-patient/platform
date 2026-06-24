import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/evaluation/communication_repository.dart';
import 'package:frontend/features/evaluation/presentation/communication_criterion_labels.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

enum _CommLoadState {
  loading,
  analyzing,
  success,
  notFound,
  forbidden,
  notFinished,
  judgeFailure,
  unknown,
}

/// Communication coaching panel for the debrief screen (#72).
class CommunicationPanel extends StatefulWidget {
  const CommunicationPanel({
    super.key,
    required this.sessionId,
    required this.communicationRepository,
  });

  final String sessionId;
  final CommunicationRepositoryContract communicationRepository;

  @override
  State<CommunicationPanel> createState() => _CommunicationPanelState();
}

class _CommunicationPanelState extends State<CommunicationPanel> {
  _CommLoadState _state = _CommLoadState.loading;
  generated.CommunicationEvaluationResponse? _evaluation;
  String? _errorDetail;
  bool _triggerAttempted = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _state = _CommLoadState.loading;
      _errorDetail = null;
    });
    try {
      final result =
          await widget.communicationRepository.getCommunicationEvaluation(
        sessionId: widget.sessionId,
      );
      if (!mounted) return;
      setState(() {
        _evaluation = result;
        _state = _CommLoadState.success;
      });
    } on DioException catch (e) {
      if (!mounted) return;
      await _handleDioOnLoad(e);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorDetail = e.toString();
        _state = _CommLoadState.unknown;
      });
    }
  }

  Future<void> _handleDioOnLoad(DioException e) async {
    final code = e.response?.statusCode;
    final detail = _detailFromDio(e);
    if (code == 409) {
      final d = (detail ?? '').toLowerCase();
      if (d.contains('not yet available') && !_triggerAttempted) {
        _triggerAttempted = true;
        await _triggerJudge();
        return;
      }
      if (d.contains('not finished')) {
        setState(() {
          _errorDetail = detail;
          _state = _CommLoadState.notFinished;
        });
        return;
      }
      setState(() {
        _errorDetail = detail;
        _state = _CommLoadState.unknown;
      });
      return;
    }
    setState(() {
      _errorDetail = detail;
      _state = switch (code) {
        403 => _CommLoadState.forbidden,
        404 => _CommLoadState.notFound,
        502 => _CommLoadState.judgeFailure,
        _ => _CommLoadState.unknown,
      };
    });
  }

  Future<void> _triggerJudge() async {
    setState(() => _state = _CommLoadState.analyzing);
    try {
      final result = await widget.communicationRepository
          .triggerCommunicationEvaluation(sessionId: widget.sessionId);
      if (!mounted) return;
      setState(() {
        _evaluation = result;
        _state = _CommLoadState.success;
      });
    } on DioException catch (e) {
      if (!mounted) return;
      final code = e.response?.statusCode;
      setState(() {
        _errorDetail = _detailFromDio(e);
        _state = switch (code) {
          403 => _CommLoadState.forbidden,
          404 => _CommLoadState.notFound,
          409 => _CommLoadState.notFinished,
          502 => _CommLoadState.judgeFailure,
          _ => _CommLoadState.unknown,
        };
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorDetail = e.toString();
        _state = _CommLoadState.unknown;
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

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      _CommLoadState.loading || _CommLoadState.analyzing => _AnalyzingBody(
          analyzing: _state == _CommLoadState.analyzing,
        ),
      _CommLoadState.success => _SuccessBody(evaluation: _evaluation!),
      _CommLoadState.notFound => _CommErrorPanel(
          icon: Icons.search_off_rounded,
          title: 'Session not found',
          message: 'Communication scoring is not available for this session.',
          detail: _errorDetail,
          onRetry: _load,
        ),
      _CommLoadState.forbidden => _CommErrorPanel(
          icon: Icons.lock_outline_rounded,
          title: 'Access denied',
          message: "You don't have access to this communication evaluation.",
          detail: _errorDetail,
          onRetry: _load,
        ),
      _CommLoadState.notFinished => _CommErrorPanel(
          icon: Icons.hourglass_empty_rounded,
          title: 'Case not finished',
          message:
              'Complete the case first, then return here for communication coaching.',
          detail: _errorDetail,
          onRetry: _load,
        ),
      _CommLoadState.judgeFailure => _CommErrorPanel(
          icon: Icons.psychology_alt_outlined,
          title: 'Communication coach unavailable',
          message:
              'The conversation coach could not analyze this session. Try again.',
          detail: _errorDetail,
          onRetry: _triggerJudge,
          retryLabel: 'Retry analysis',
        ),
      _CommLoadState.unknown => _CommErrorPanel(
          icon: Icons.error_outline_rounded,
          title: 'Something went wrong',
          message: 'Could not load communication coaching.',
          detail: _errorDetail,
          onRetry: _load,
        ),
    };
  }
}

class _AnalyzingBody extends StatelessWidget {
  const _AnalyzingBody({required this.analyzing});

  final bool analyzing;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroHeader(
                  subtitle: analyzing
                      ? 'Our coach is reviewing your doctor–patient conversation. This usually takes a few seconds.'
                      : 'Checking for saved communication feedback…',
                ),
                const SizedBox(height: 20),
                ...List.generate(3, (_) => const _CriterionSkeleton()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessBody extends StatelessWidget {
  const _SuccessBody({required this.evaluation});

  final generated.CommunicationEvaluationResponse evaluation;

  @override
  Widget build(BuildContext context) {
    final total = evaluation.totalScore.toDouble();
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroHeader(
                  subtitle:
                      'Feedback on your communication style — not clinical advice.',
                ),
                const SizedBox(height: 20),
                _ScoreHero(totalScore: total),
                const SizedBox(height: 20),
                Text(
                  'Rubric breakdown',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Each criterion is scored 0–5 with a quote from your conversation.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 12),
                ...evaluation.criteria.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _CriterionCard(criterion: c),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Model ${evaluation.model} · rubric ${evaluation.promptVersion} · '
                  '${evaluation.createdAt.toLocal()}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.tertiaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.heroTint, AppColors.heroTintEnd],
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border:
            Border.fromBorderSide(BorderSide(color: AppColors.borderSubtle)),
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
              Icons.record_voice_over_rounded,
              color: AppColors.brandTeal,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Communication coaching',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
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

class _ScoreHero extends StatelessWidget {
  const _ScoreHero({required this.totalScore});

  final double totalScore;

  Color get _ringColor {
    if (totalScore >= 80) return AppColors.brandTeal;
    if (totalScore >= 60) return AppColors.primaryBlue;
    return AppColors.difficultyMedium;
  }

  @override
  Widget build(BuildContext context) {
    final progress = (totalScore / 100).clamp(0.0, 1.0);
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 104,
              height: 104,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 104,
                    height: 104,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 7,
                      backgroundColor: AppColors.surfaceMuted,
                      color: _ringColor,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: totalScore.toStringAsFixed(0),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: _ringColor,
                          ),
                        ),
                        TextSpan(
                          text: ' /100',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total communication score',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _scoreBandLabel(totalScore),
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _scoreBandLabel(double score) {
    if (score >= 80) return 'Strong rapport and interviewing skills.';
    if (score >= 60) return 'Solid foundation with room to refine technique.';
    return 'Focus on open questions, empathy, and structure.';
  }
}

class _CriterionCard extends StatefulWidget {
  const _CriterionCard({required this.criterion});

  final generated.CommunicationCriterionResponse criterion;

  @override
  State<_CriterionCard> createState() => _CriterionCardState();
}

class _CriterionCardState extends State<_CriterionCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final c = widget.criterion;
    final label = communicationCriterionLabel(c.criterion);
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  _ScoreDots(score: c.score),
                  const SizedBox(width: 8),
                  Icon(
                    _expanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: AppColors.tertiaryText,
                    size: 20,
                  ),
                ],
              ),
              if (_expanded) ...[
                const SizedBox(height: 12),
                Text(
                  c.rationale,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.45,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(8),
                    border: const Border(
                      left: BorderSide(color: AppColors.brandTeal, width: 3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.format_quote_rounded,
                        size: 18,
                        color: AppColors.brandTeal,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SelectableText(
                          c.quote.isEmpty ? '—' : c.quote,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreDots extends StatelessWidget {
  const _ScoreDots({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < score;
        return Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(left: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? AppColors.primaryBlue : AppColors.borderSubtle,
          ),
        );
      }),
    );
  }
}

class _CriterionSkeleton extends StatelessWidget {
  const _CriterionSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
        child: const SizedBox(height: 72),
      ),
    );
  }
}

class _CommErrorPanel extends StatelessWidget {
  const _CommErrorPanel({
    required this.icon,
    required this.title,
    required this.message,
    this.detail,
    required this.onRetry,
    this.retryLabel = 'Retry',
  });

  final IconData icon;
  final String title;
  final String message;
  final String? detail;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Material(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.borderSubtle),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(icon, size: 40, color: AppColors.danger),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(message, style: GoogleFonts.inter(fontSize: 14)),
                    if (detail != null && detail!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        detail!,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: onRetry,
                      child: Text(retryLabel),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

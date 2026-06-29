import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/structured_conclusions_summary.dart';
import 'package:frontend/domains/evaluation/communication_repository.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/features/evaluation/presentation/communication_panel.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

void _goToCaseLibrary(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

/// Loads and displays server evaluation (scores, findings, reference, conclusions).
class DebriefScreen extends StatefulWidget {
  const DebriefScreen({
    super.key,
    required this.caseItem,
    required this.sessionId,
    required this.evaluationRepository,
    required this.communicationRepository,
  });

  final generated.CaseResponse caseItem;
  final String sessionId;
  final EvaluationRepositoryContract evaluationRepository;
  final CommunicationRepositoryContract communicationRepository;

  @override
  State<DebriefScreen> createState() => _DebriefScreenState();
}

enum _LoadState { loading, success, forbidden, notFound, conflict, unknown }

class _DebriefScreenState extends State<DebriefScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  _LoadState _state = _LoadState.loading;
  generated.DebriefResponse? _debrief;
  String? _errorDetail;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _state = _LoadState.loading;
      _errorDetail = null;
    });
    try {
      final d = await widget.evaluationRepository.getDebrief(
        sessionId: widget.sessionId,
      );
      if (!mounted) return;
      setState(() {
        _debrief = d;
        _state = _LoadState.success;
      });
    } on DioException catch (e) {
      if (!mounted) return;
      final code = e.response?.statusCode;
      final detail = _detailFromDio(e);
      setState(() {
        _errorDetail = detail;
        switch (code) {
          case 403:
            _state = _LoadState.forbidden;
            break;
          case 404:
            _state = _LoadState.notFound;
            break;
          case 409:
            _state = _LoadState.conflict;
            break;
          default:
            _state = _LoadState.unknown;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorDetail = e.toString();
        _state = _LoadState.unknown;
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

  String _conflictUserMessage(String? detail) {
    final d = (detail ?? '').toLowerCase();
    if (d.contains('not finished')) {
      return 'This session is not finished yet. Complete the case first, then open the evaluation again.';
    }
    if (d.contains('not yet available') || d.contains('evaluation not')) {
      return 'Scoring is still in progress. Try again in a few moments.';
    }
    return detail ?? 'The evaluation cannot be shown right now.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
        title: Text(
          'Evaluation',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _goToCaseLibrary(context),
            icon: const Icon(Icons.grid_view_rounded, size: 20),
            label: Text(
              'Case library',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: _state == _LoadState.success
            ? TabBar(
                controller: _tabController,
                labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
                unselectedLabelStyle: GoogleFonts.inter(),
                indicatorColor: AppColors.primaryBlue,
                labelColor: AppColors.primaryBlue,
                unselectedLabelColor: AppColors.secondaryText,
                tabs: const [
                  Tab(text: 'Clinical'),
                  Tab(text: 'Communication'),
                ],
              )
            : null,
      ),
      body: switch (_state) {
        _LoadState.loading => _LoadingBody(),
        _LoadState.success => TabBarView(
          controller: _tabController,
          children: [
            _SuccessBody(
              caseItem: widget.caseItem,
              sessionId: widget.sessionId,
              debrief: _debrief!,
            ),
            CommunicationPanel(
              sessionId: widget.sessionId,
              communicationRepository: widget.communicationRepository,
            ),
          ],
        ),
        _LoadState.forbidden => _ErrorPanel(
          title: 'Access denied',
          message: "You don't have access to this evaluation.",
          detail: _errorDetail,
          onRetry: _load,
        ),
        _LoadState.notFound => _ErrorPanel(
          title: 'Session not found',
          message: 'Session not found.',
          detail: _errorDetail,
          onRetry: _load,
        ),
        _LoadState.conflict => _ErrorPanel(
          title: 'Evaluation unavailable',
          message: _conflictUserMessage(_errorDetail),
          detail: _errorDetail,
          onRetry: _load,
        ),
        _LoadState.unknown => _ErrorPanel(
          title: 'Something went wrong',
          message: 'Could not load the evaluation.',
          detail: _errorDetail,
          onRetry: _load,
        ),
      },
    );
  }
}

class _LoadingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Material(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.borderSubtle),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      backgroundColor: AppColors.borderSubtle,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Loading evaluation…',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fetching scores, findings, and feedback from the server.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        ConstrainedBox(
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
                  Icon(
                    Icons.info_outline_rounded,
                    size: 40,
                    color: AppColors.danger,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.primaryText,
                    ),
                  ),
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
                  FilledButton(onPressed: onRetry, child: const Text('Retry')),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () => _goToCaseLibrary(context),
                    child: const Text('Case library'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessBody extends StatelessWidget {
  const _SuccessBody({
    required this.caseItem,
    required this.sessionId,
    required this.debrief,
  });

  final generated.CaseResponse caseItem;
  final String sessionId;
  final generated.DebriefResponse debrief;

  @override
  Widget build(BuildContext context) {
    final grouped = _groupFindings(debrief.findings);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${caseItem.caseId} · ${caseItem.title}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Session $sessionId · scored ${debrief.scoredAt.toLocal()}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 20),
                _ScoresCard(debrief: debrief),
                const SizedBox(height: 16),
                Text(
                  'Findings',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (debrief.findings.isEmpty)
                  Text(
                    'No findings recorded for this run.',
                    style: GoogleFonts.inter(color: AppColors.secondaryText),
                  )
                else
                  ...grouped.entries.expand((e) {
                    return [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 6),
                        child: Text(
                          e.key.isEmpty ? 'General' : e.key,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                      ...e.value.map((f) => _FindingCard(finding: f)),
                    ];
                  }),
                const SizedBox(height: 20),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    'Reference solution',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                  ),
                  childrenPadding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 12,
                  ),
                  children: [
                    if (debrief.referenceSolution.isEmpty)
                      Text(
                        'No reference data.',
                        style: GoogleFonts.inter(
                          color: AppColors.secondaryText,
                        ),
                      )
                    else
                      ...debrief.referenceSolution.entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _JsonValueWidget(value: entry.value?.value),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Your conclusions (submitted)',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                ...structuredConclusionsFromBuiltMap(debrief.conclusions),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => _goToCaseLibrary(context),
                  child: Text(
                    'Back to case library',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Map<String, List<generated.EvaluationFindingResponse>> _groupFindings(
    BuiltList<generated.EvaluationFindingResponse> findings,
  ) {
    final map = <String, List<generated.EvaluationFindingResponse>>{};
    for (final f in findings) {
      map.putIfAbsent(f.category, () => []).add(f);
    }
    for (final list in map.values) {
      list.sort((a, b) {
        final ra = _severityRank(a.severity);
        final rb = _severityRank(b.severity);
        final c = ra.compareTo(rb);
        if (c != 0) return c;
        return a.severity.compareTo(b.severity);
      });
    }
    return map;
  }

  int _severityRank(String severity) {
    final s = severity.toLowerCase();
    if (s == 'critical') return 0;
    if (s == 'major') return 1;
    return 2;
  }
}

class _ScoresCard extends StatelessWidget {
  const _ScoresCard({required this.debrief});

  final generated.DebriefResponse debrief;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scores',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total: ${debrief.totalScore}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _sub('Diagnosis', debrief.scoreDiagnosis),
                _sub('Diagnostics', debrief.scoreDiagnostics),
                _sub('Treatment', debrief.scoreTreatment),
                _sub('Safety', debrief.scoreSafety),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Scored at: ${debrief.scoredAt.toLocal()}',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sub(String label, num v) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '$v',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ],
    );
  }
}

class _FindingCard extends StatelessWidget {
  const _FindingCard({required this.finding});

  final generated.EvaluationFindingResponse finding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surfaceMuted,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.borderSubtle),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _chip('Type', finding.type),
                  _chip('Severity', finding.severity),
                  _chip('Deduction', '${finding.deductionPoints} pts'),
                ],
              ),
              const SizedBox(height: 10),
              _field('Expected', finding.expected),
              _field('Actual', finding.actual),
              _field('Why it matters', finding.whyMatters),
              _field('How to correct', finding.howToCorrect),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String k, String v) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Text(
        '$k: $v',
        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _field(String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 2),
          SelectableText(
            text.isEmpty ? '—' : text,
            style: GoogleFonts.inter(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _JsonValueWidget extends StatelessWidget {
  const _JsonValueWidget({required this.value, this.indent = 0});

  final Object? value;
  final double indent;

  @override
  Widget build(BuildContext context) {
    final pad = EdgeInsets.only(left: indent);
    if (value == null) {
      return Padding(
        padding: pad,
        child: Text(
          'null',
          style: GoogleFonts.inter(color: AppColors.tertiaryText),
        ),
      );
    }
    if (value is Map) {
      final m = Map<Object?, Object?>.from(value as Map);
      if (m.isEmpty) {
        return Padding(
          padding: pad,
          child: Text('{}', style: GoogleFonts.inter(fontSize: 13)),
        );
      }
      return Padding(
        padding: pad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: m.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e.key}:',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  _JsonValueWidget(value: e.value, indent: indent + 12),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }
    if (value is List) {
      final list = value as List<Object?>;
      if (list.isEmpty) {
        return Padding(
          padding: pad,
          child: Text('[]', style: GoogleFonts.inter(fontSize: 13)),
        );
      }
      return Padding(
        padding: pad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(list.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$i. ',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  Expanded(child: _JsonValueWidget(value: list[i], indent: 0)),
                ],
              ),
            );
          }),
        ),
      );
    }
    return Padding(
      padding: pad,
      child: SelectableText(
        value.toString(),
        style: GoogleFonts.inter(fontSize: 13),
      ),
    );
  }
}

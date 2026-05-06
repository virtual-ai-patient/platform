import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/cases/presentation/simulation_debrief_screen.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

/// Multi-step clinical reasoning form: matches [ConclusionsRequest] / PATCH conclusions and POST finish.
class SimulationConclusionsScreen extends StatefulWidget {
  const SimulationConclusionsScreen({
    super.key,
    required this.caseItem,
    required this.sessionId,
    required this.sessionRepository,
  });

  final generated.CaseResponse caseItem;
  final String sessionId;
  final SessionRepositoryContract sessionRepository;

  @override
  State<SimulationConclusionsScreen> createState() =>
      _SimulationConclusionsScreenState();
}

class _MedRow {
  _MedRow()
      : name = TextEditingController(),
        dose = TextEditingController(),
        route = TextEditingController();

  final TextEditingController name;
  final TextEditingController dose;
  final TextEditingController route;

  void dispose() {
    name.dispose();
    dose.dispose();
    route.dispose();
  }
}

class _DiffRow {
  _DiffRow() : controller = TextEditingController();
  final TextEditingController controller;
  void dispose() => controller.dispose();
}

class _SimulationConclusionsScreenState
    extends State<SimulationConclusionsScreen> {
  int _step = 0;
  bool _busy = false;

  final List<_DiffRow> _diffRows = [_DiffRow()];
  final TextEditingController _finalDiagnosisCtrl = TextEditingController();
  bool _finalTouched = false;

  final List<_MedRow> _medRows = [_MedRow()];
  final List<TextEditingController> _nonPharmCtrls = [TextEditingController()];
  final List<TextEditingController> _referralCtrls = [TextEditingController()];
  final List<TextEditingController> _followUpCtrls = [TextEditingController()];

  @override
  void dispose() {
    for (final d in _diffRows) {
      d.dispose();
    }
    _finalDiagnosisCtrl.dispose();
    for (final m in _medRows) {
      m.dispose();
    }
    for (final c in _nonPharmCtrls) {
      c.dispose();
    }
    for (final c in _referralCtrls) {
      c.dispose();
    }
    for (final c in _followUpCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  List<String> _diagnosisSuggestions() {
    final fromCase = <String>{
      ...widget.caseItem.differential,
      if (widget.caseItem.finalDiagnosis.isNotEmpty)
        widget.caseItem.finalDiagnosis,
    };
    for (final d in _diffRows) {
      final t = d.controller.text.trim();
      if (t.isNotEmpty) {
        fromCase.add(t);
      }
    }
    return fromCase.toList()..sort();
  }

  BuiltList<generated.DifferentialDiagnosisItem> _buildDifferentialItems() {
    final items = <generated.DifferentialDiagnosisItem>[];
    var rank = 1;
    for (final row in _diffRows) {
      final cond = row.controller.text.trim();
      if (cond.isEmpty) continue;
      items.add(
        generated.DifferentialDiagnosisItem(
          (b) => b
            ..rank = rank
            ..condition = cond,
        ),
      );
      rank++;
    }
    return BuiltList<generated.DifferentialDiagnosisItem>(items);
  }

  generated.TreatmentPlan _buildTreatmentPlan() {
    final meds = <generated.Medication>[];
    for (final m in _medRows) {
      final name = m.name.text.trim();
      final dose = m.dose.text.trim();
      final route = m.route.text.trim();
      if (name.isEmpty && dose.isEmpty && route.isEmpty) {
        continue;
      }
      meds.add(
        generated.Medication(
          (b) => b
            ..name = name
            ..dose = dose.isEmpty ? '—' : dose
            ..route = route.isEmpty ? '—' : route,
        ),
      );
    }
    List<String> stringLines(List<TextEditingController> ctrls) => ctrls
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);

    return generated.TreatmentPlan(
      (b) => b
        ..medications.replace(BuiltList<generated.Medication>(meds))
        ..nonPharmacological
            .replace(BuiltList<String>(stringLines(_nonPharmCtrls)))
        ..referrals.replace(BuiltList<String>(stringLines(_referralCtrls)))
        ..followUp.replace(BuiltList<String>(stringLines(_followUpCtrls))),
    );
  }

  String _treatmentPlanSummaryText() {
    final plan = _buildTreatmentPlan();
    final buf = StringBuffer();
    final meds = plan.medications?.toList() ?? [];
    if (meds.isNotEmpty) {
      buf.writeln('Medications:');
      for (final m in meds) {
        buf.writeln('• ${m.name} — ${m.dose} (${m.route})');
      }
    }
    void addList(String title, BuiltList<String>? list) {
      final l = list?.toList() ?? [];
      if (l.isEmpty) return;
      buf.writeln(title);
      for (final s in l) {
        buf.writeln('• $s');
      }
    }

    addList('Non-pharmacological:', plan.nonPharmacological);
    addList('Referrals:', plan.referrals);
    addList('Follow-up:', plan.followUp);
    final t = buf.toString().trim();
    return t.isEmpty ? 'No treatment plan entries.' : t;
  }

  Future<void> _persistStep0() async {
    await widget.sessionRepository.updateConclusions(
      sessionId: widget.sessionId,
      request: generated.ConclusionsRequest(
        (b) => b..differentialDiagnoses.replace(_buildDifferentialItems()),
      ),
    );
  }

  Future<void> _persistStep1() async {
    await widget.sessionRepository.updateConclusions(
      sessionId: widget.sessionId,
      request: generated.ConclusionsRequest(
        (b) => b..finalDiagnosis = _finalDiagnosisCtrl.text.trim(),
      ),
    );
  }

  Future<void> _persistStep2() async {
    await widget.sessionRepository.updateConclusions(
      sessionId: widget.sessionId,
      request: generated.ConclusionsRequest(
        (b) => b..treatmentPlan.replace(_buildTreatmentPlan()),
      ),
    );
  }

  String? _apiDetail(Object? err) {
    if (err is DioException) {
      final data = err.response?.data;
      if (data is Map && data['detail'] != null) {
        return data['detail'].toString();
      }
      return err.message;
    }
    return err.toString();
  }

  Future<void> _onNext() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (_step == 0) {
        await _persistStep0();
        if (mounted) setState(() => _step = 1);
      } else if (_step == 1) {
        _finalTouched = true;
        final fd = _finalDiagnosisCtrl.text.trim();
        if (fd.isEmpty) {
          if (mounted) setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enter a final diagnosis to continue.'),
            ),
          );
          return;
        }
        await _persistStep1();
        if (mounted) setState(() => _step = 2);
      } else if (_step == 2) {
        await _persistStep2();
        if (mounted) setState(() => _step = 3);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_apiDetail(e) ?? 'Could not save.')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _onBack() async {
    if (_step == 0) {
      final shouldClose = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Leave clinical reasoning?',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Draft entries on this step are not saved until you press Next.',
            style: GoogleFonts.inter(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Stay'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Leave'),
            ),
          ],
        ),
      );
      if (shouldClose == true && mounted) {
        Navigator.of(context).pop();
      }
      return;
    }
    setState(() => _step -= 1);
  }

  Future<void> _confirmFinish() async {
    final fd = _finalDiagnosisCtrl.text.trim();
    if (fd.isEmpty) {
      setState(() {
        _finalTouched = true;
        _step = 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Final diagnosis is required before finishing.'),
        ),
      );
      return;
    }

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Finish case?',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Final diagnosis: $fd',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(
                'Treatment plan',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _treatmentPlanSummaryText(),
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Review again'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Submit & finish'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;

    setState(() => _busy = true);
    try {
      final response = await widget.sessionRepository.finishSession(
        sessionId: widget.sessionId,
      );
      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => SimulationDebriefScreen(
            caseItem: widget.caseItem,
            conclusionsResponse: response,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_apiDetail(e) ?? 'Could not finish case.')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _diagnosisSuggestions();
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      appBar: AppBar(
        title: Text(
          'Finish case',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_step + 1) / 4,
            backgroundColor: AppColors.borderSubtle,
            color: AppColors.primaryBlue,
            minHeight: 3,
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Material(
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.borderSubtle),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          [
                            'Step 1 · Differential diagnosis',
                            'Step 2 · Final diagnosis',
                            'Step 3 · Treatment plan',
                            'Step 4 · Review',
                          ][_step],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceMuted,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderSubtle),
                          ),
                          child: Text(
                            _step < 3
                                ? 'Press Next to save this step to the session.'
                                : 'Review everything before final submission.',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(child: _buildStepBody(context, suggestions)),
                        const SizedBox(height: 12),
                        _buildFooterActions(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepBody(BuildContext context, List<String> suggestions) {
    switch (_step) {
      case 0:
        return _buildDifferentialStep();
      case 1:
        return _buildFinalStep(suggestions);
      case 2:
        return _buildTreatmentStep();
      default:
        return _buildReviewStep();
    }
  }

  Widget _buildFooterActions() {
    final isFinalStep = _step == 3;
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 8,
      spacing: 8,
      children: [
        if (_step == 0)
          OutlinedButton(
            onPressed: _busy ? null : _onBack,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(120, 44),
            ),
            child: const Text('Cancel'),
          )
        else
          OutlinedButton.icon(
            onPressed: _busy ? null : _onBack,
            icon: const Icon(Icons.arrow_back_rounded, size: 16),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(120, 44),
            ),
            label: const Text('Back'),
          ),
        if (!isFinalStep)
          FilledButton.icon(
            onPressed: _busy ? null : _onNext,
            style: FilledButton.styleFrom(
              minimumSize: const Size(160, 44),
            ),
            icon: _busy
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.arrow_forward_rounded, size: 16),
            label: Text(_busy ? 'Saving...' : 'Save & Next'),
          )
        else
          FilledButton.icon(
            onPressed: _busy ? null : _confirmFinish,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.successTeal,
              minimumSize: const Size(180, 44),
            ),
            icon: const Icon(Icons.check_rounded, size: 16),
            label: const Text('Confirm & Finish'),
          ),
      ],
    );
  }

  Widget _buildDifferentialStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Rank hypotheses (drag to reorder). Add rows as needed.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ReorderableListView.builder(
            buildDefaultDragHandles: false,
            itemCount: _diffRows.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final row = _diffRows.removeAt(oldIndex);
                _diffRows.insert(newIndex, row);
              });
            },
            itemBuilder: (context, index) {
              final row = _diffRows[index];
              return Card(
                key: ValueKey<Object>(row),
                margin: const EdgeInsets.only(bottom: 8),
                color: AppColors.surfaceMuted,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: AppColors.borderSubtle),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  leading: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle_rounded,
                        color: AppColors.secondaryText),
                  ),
                  title: TextField(
                    controller: row.controller,
                    decoration: InputDecoration(
                      labelText: 'Diagnosis #${index + 1}',
                      isDense: true,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  trailing: IconButton(
                    tooltip: 'Remove',
                    onPressed: _diffRows.length <= 1
                        ? null
                        : () => setState(() {
                              row.dispose();
                              _diffRows.removeAt(index);
                            }),
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.danger),
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _diffRows.add(_DiffRow())),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add diagnosis'),
          ),
        ),
      ],
    );
  }

  Widget _buildFinalStep(List<String> suggestions) {
    final showError = _finalTouched && _finalDiagnosisCtrl.text.trim().isEmpty;
    final filtered = _finalDiagnosisCtrl.text.trim().isEmpty
        ? suggestions.take(10)
        : suggestions
            .where((s) => s
                .toLowerCase()
                .contains(_finalDiagnosisCtrl.text.trim().toLowerCase()))
            .take(10);
    return ListView(
      children: [
        Text(
          'Type a final diagnosis or tap a suggestion from the case.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _finalDiagnosisCtrl,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: 'Final diagnosis *',
            errorText: showError ? 'Required to finish the case' : null,
            border: const OutlineInputBorder(),
            hintText: 'e.g. ST-elevation myocardial infarction',
          ),
        ),
        if (filtered.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            'Suggestions',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filtered
                .map(
                  (s) => ActionChip(
                    label: Text(s, style: GoogleFonts.inter(fontSize: 12)),
                    onPressed: () {
                      _finalDiagnosisCtrl.text = s;
                      setState(() {});
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildTreatmentStep() {
    return ListView(
      children: [
        Text(
          'Medications (name, dose, route). Optional rows are skipped.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < _medRows.length; i++) _medCard(i),
        TextButton.icon(
          onPressed: () => setState(() => _medRows.add(_MedRow())),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add medication'),
        ),
        const SizedBox(height: 16),
        Text(
          'Non-pharmacological measures',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        ..._dynamicStringFields(_nonPharmCtrls, 'e.g. Oxygen, bed rest'),
        TextButton.icon(
          onPressed: () =>
              setState(() => _nonPharmCtrls.add(TextEditingController())),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add line'),
        ),
        const SizedBox(height: 12),
        Text(
          'Referrals',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        ..._dynamicStringFields(_referralCtrls, 'e.g. Cardiology'),
        TextButton.icon(
          onPressed: () =>
              setState(() => _referralCtrls.add(TextEditingController())),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add referral'),
        ),
        const SizedBox(height: 12),
        Text(
          'Follow-up',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        ..._dynamicStringFields(_followUpCtrls, 'e.g. Repeat troponin'),
        TextButton.icon(
          onPressed: () =>
              setState(() => _followUpCtrls.add(TextEditingController())),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add follow-up item'),
        ),
      ],
    );
  }

  Widget _medCard(int i) {
    final m = _medRows[i];
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: AppColors.surfaceMuted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Medication ${i + 1}',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (_medRows.length > 1)
                  IconButton(
                    tooltip: 'Remove',
                    onPressed: () => setState(() {
                      m.dispose();
                      _medRows.removeAt(i);
                    }),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: m.name,
              decoration: const InputDecoration(
                labelText: 'Name',
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: m.dose,
                    decoration: const InputDecoration(
                      labelText: 'Dose',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: m.route,
                    decoration: const InputDecoration(
                      labelText: 'Route',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _dynamicStringFields(
    List<TextEditingController> ctrls,
    String hint,
  ) {
    return List<Widget>.generate(ctrls.length, (i) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: ctrls[i],
                decoration: InputDecoration(
                  hintText: hint,
                  isDense: true,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            if (ctrls.length > 1)
              IconButton(
                onPressed: () => setState(() {
                  ctrls[i].dispose();
                  ctrls.removeAt(i);
                }),
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildReviewStep() {
    final diff = _buildDifferentialItems();
    final fd = _finalDiagnosisCtrl.text.trim();
    return ListView(
      children: [
        Text(
          'Review your submission. Go back will not undo saved drafts on the server.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Differential (ranked)',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        if (diff.isEmpty)
          Text('—', style: GoogleFonts.inter(color: AppColors.secondaryText))
        else
          ...diff.map(
            (d) => Text(
              '${d.rank}. ${d.condition}',
              style: GoogleFonts.inter(fontSize: 14),
            ),
          ),
        const SizedBox(height: 16),
        Text(
          'Final diagnosis',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          fd.isEmpty ? '—' : fd,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: fd.isEmpty ? AppColors.danger : AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Treatment plan',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          _treatmentPlanSummaryText(),
          style: GoogleFonts.inter(fontSize: 13),
        ),
      ],
    );
  }
}

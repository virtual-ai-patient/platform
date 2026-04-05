import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

const _finalDiagnosisPlaceholders = {
  'to be determined',
  'tbd',
  'unknown',
  'n/a',
  'na',
  'pending',
  '???',
  'none',
  'placeholder',
};

/// Client-side mirror of backend [validate_final_diagnosis_value] (cases/request.py).
String? validateFinalDiagnosisClient(String raw) {
  final t = raw.trim();
  if (t.length < 2) {
    return 'Final diagnosis (ground truth) must be at least 2 characters.';
  }
  if (_finalDiagnosisPlaceholders.contains(t.toLowerCase())) {
    return 'Enter a specific final diagnosis, not a placeholder.';
  }
  return null;
}

/// Manage tab: edit-mode switch and **New case** (same screen layout as browse).
class EducatorManageToolbar extends StatelessWidget {
  const EducatorManageToolbar({
    super.key,
    required this.editMode,
    required this.onEditModeChanged,
    required this.creatingCase,
    required this.onNewCase,
  });

  final bool editMode;
  final ValueChanged<bool> onEditModeChanged;
  final bool creatingCase;
  final VoidCallback onNewCase;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceMuted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Same grid and filters as Browse. Turn Edit on to change or remove cases from the cards.',
              style: GoogleFonts.inter(
                fontSize: 13,
                height: 1.4,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Switch.adaptive(
                      value: editMode,
                      activeThumbColor: AppColors.primaryBlue,
                      onChanged: onEditModeChanged,
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: creatingCase ? null : onNewCase,
                  icon: creatingCase
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_rounded, size: 20),
                  label: Text(
                    'New case',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Create flow: dialog → POST /cases → [onRefresh].
Future<void> runEducatorCreateCaseFlow(
  BuildContext context, {
  required CaseRepositoryContract caseRepository,
  required Future<void> Function() onRefresh,
  void Function(bool working)? onWorking,
}) async {
  final result = await showDialog<_NewCaseDialogResult>(
    context: context,
    builder: (ctx) => const _NewCaseDialog(),
  );

  if (result == null || !context.mounted) {
    return;
  }
  if (result.caseId.isEmpty ||
      result.title.isEmpty ||
      result.specialty.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Case ID, title, and specialty are required.'),
      ),
    );
    return;
  }
  final dxErr = validateFinalDiagnosisClient(result.finalDiagnosis);
  if (dxErr != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(dxErr)));
    return;
  }

  onWorking?.call(true);
  try {
    final request = _createCaseRequestFromForm(
      caseId: result.caseId,
      title: result.title,
      specialty: result.specialty,
      difficulty: result.difficulty,
      chiefComplaint:
          result.chiefComplaint.isEmpty ? result.title : result.chiefComplaint,
      finalDiagnosis: result.finalDiagnosis.trim(),
    );
    await caseRepository.createCase(request);
    await onRefresh();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Created case "${result.caseId}"')),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not create case: $e')),
      );
    }
  } finally {
    onWorking?.call(false);
  }
}

/// Edit flow: dialog → PUT /cases/{id} → [onRefresh].
Future<void> runEducatorEditCaseFlow(
  BuildContext context, {
  required generated.CaseResponse initial,
  required CaseRepositoryContract caseRepository,
  required Future<void> Function() onRefresh,
  void Function(bool working)? onWorking,
}) async {
  final result = await showDialog<_EditCaseDialogResult>(
    context: context,
    builder: (ctx) => _EditCaseDialog(initial: initial),
  );
  if (result == null || !context.mounted) {
    return;
  }

  onWorking?.call(true);
  try {
    final body = generated.UpdateCaseRequest(
      (b) => b
        ..title = result.title
        ..specialty = result.specialty
        ..difficulty = result.difficulty
        ..chiefComplaint = result.chiefComplaint
        ..persona = result.persona
        ..age = result.age
        ..historyOfPresentIllness = result.historyOfPresentIllness
        ..finalDiagnosis = result.finalDiagnosis
        ..sex = result.sex
        ..status = result.status,
    );
    await caseRepository.updateCase(id: initial.id, updateCaseRequest: body);
    await onRefresh();
    if (context.mounted) {
      final msg = switch (result.status) {
        generated.UpdateCaseRequestStatusEnum.draft => 'Saved as draft',
        generated.UpdateCaseRequestStatusEnum.review => 'Sent to review',
        generated.UpdateCaseRequestStatusEnum.published => 'Published',
        _ => 'Case updated',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update case: $e')),
      );
    }
  } finally {
    onWorking?.call(false);
  }
}

/// Delete flow: confirm → DELETE /cases/{id} → [onRefresh].
Future<void> runEducatorDeleteCaseFlow(
  BuildContext context, {
  required generated.CaseResponse c,
  required CaseRepositoryContract caseRepository,
  required Future<void> Function() onRefresh,
  void Function(bool working)? onWorking,
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'Delete case?',
        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
      content: Text(
        '“${c.title}” (${c.caseId}) will be removed permanently.',
        style: GoogleFonts.inter(fontSize: 14, height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.danger,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) {
    return;
  }

  onWorking?.call(true);
  try {
    await caseRepository.deleteCase(id: c.id);
    await onRefresh();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted “${c.title}”')),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete case: $e')),
      );
    }
  } finally {
    onWorking?.call(false);
  }
}

class _NewCaseDialogResult {
  const _NewCaseDialogResult({
    required this.caseId,
    required this.title,
    required this.specialty,
    required this.chiefComplaint,
    required this.finalDiagnosis,
    required this.difficulty,
  });

  final String caseId;
  final String title;
  final String specialty;
  final String chiefComplaint;
  final String finalDiagnosis;
  final generated.CreateCaseRequestDifficultyEnum difficulty;
}

class _NewCaseDialog extends StatefulWidget {
  const _NewCaseDialog();

  @override
  State<_NewCaseDialog> createState() => _NewCaseDialogState();
}

class _NewCaseDialogState extends State<_NewCaseDialog> {
  late final TextEditingController _caseId;
  late final TextEditingController _title;
  late final TextEditingController _specialty;
  late final TextEditingController _chief;
  late final TextEditingController _finalDx;
  generated.CreateCaseRequestDifficultyEnum _difficulty =
      generated.CreateCaseRequestDifficultyEnum.medium;

  @override
  void initState() {
    super.initState();
    _caseId = TextEditingController();
    _title = TextEditingController();
    _specialty = TextEditingController(text: 'emergency_medicine');
    _chief = TextEditingController();
    _finalDx = TextEditingController();
  }

  @override
  void dispose() {
    _caseId.dispose();
    _title.dispose();
    _specialty.dispose();
    _chief.dispose();
    _finalDx.dispose();
    super.dispose();
  }

  void _submit() {
    final dxErr = validateFinalDiagnosisClient(_finalDx.text);
    if (dxErr != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(dxErr)));
      return;
    }
    Navigator.of(context).pop(
      _NewCaseDialogResult(
        caseId: _caseId.text.trim(),
        title: _title.text.trim(),
        specialty: _specialty.text.trim(),
        chiefComplaint: _chief.text.trim(),
        finalDiagnosis: _finalDx.text.trim(),
        difficulty: _difficulty,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'New case',
        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _caseId,
              decoration: const InputDecoration(
                labelText: 'Case ID (unique, e.g. ward_chest_01)',
              ),
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _specialty,
              decoration: const InputDecoration(
                labelText: 'Specialty (slug, e.g. emergency_medicine)',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _chief,
              decoration: const InputDecoration(
                labelText: 'Chief complaint',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _finalDx,
              decoration: const InputDecoration(
                labelText: 'Final diagnosis (ground truth, required)',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Difficulty',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 4),
            DropdownButton<generated.CreateCaseRequestDifficultyEnum>(
              isExpanded: true,
              value: _difficulty,
              items: const [
                DropdownMenuItem(
                  value: generated.CreateCaseRequestDifficultyEnum.easy,
                  child: Text('Easy'),
                ),
                DropdownMenuItem(
                  value: generated.CreateCaseRequestDifficultyEnum.medium,
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: generated.CreateCaseRequestDifficultyEnum.hard,
                  child: Text('Hard'),
                ),
              ],
              onChanged: (v) {
                if (v != null) {
                  setState(() => _difficulty = v);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Create'),
        ),
      ],
    );
  }
}

class _EditCaseDialogResult {
  const _EditCaseDialogResult({
    required this.title,
    required this.specialty,
    required this.chiefComplaint,
    required this.persona,
    required this.historyOfPresentIllness,
    required this.finalDiagnosis,
    required this.age,
    required this.difficulty,
    required this.sex,
    required this.status,
  });

  final String title;
  final String specialty;
  final String chiefComplaint;
  final String persona;
  final String historyOfPresentIllness;
  final String finalDiagnosis;
  final int age;
  final generated.UpdateCaseRequestDifficultyEnum difficulty;
  final generated.UpdateCaseRequestSexEnum sex;
  final generated.UpdateCaseRequestStatusEnum status;
}

class _EditCaseDialog extends StatefulWidget {
  const _EditCaseDialog({required this.initial});

  final generated.CaseResponse initial;

  @override
  State<_EditCaseDialog> createState() => _EditCaseDialogState();
}

class _EditCaseDialogState extends State<_EditCaseDialog> {
  late final TextEditingController _title;
  late final TextEditingController _specialty;
  late final TextEditingController _chief;
  late final TextEditingController _persona;
  late final TextEditingController _hpi;
  late final TextEditingController _dx;
  late final TextEditingController _age;
  late generated.UpdateCaseRequestDifficultyEnum _difficulty;
  late generated.UpdateCaseRequestSexEnum _sex;
  String? _ageError;

  @override
  void initState() {
    super.initState();
    final c = widget.initial;
    _title = TextEditingController(text: c.title);
    _specialty = TextEditingController(text: c.specialty);
    _chief = TextEditingController(text: c.chiefComplaint);
    _persona = TextEditingController(text: c.persona);
    _hpi = TextEditingController(text: c.historyOfPresentIllness);
    _dx = TextEditingController(text: c.finalDiagnosis);
    _age = TextEditingController(text: '${c.age}');
    _difficulty = _parseUpdateDifficulty(c.difficulty);
    _sex = _parseUpdateSex(c.sex);
  }

  @override
  void dispose() {
    _title.dispose();
    _specialty.dispose();
    _chief.dispose();
    _persona.dispose();
    _hpi.dispose();
    _dx.dispose();
    _age.dispose();
    super.dispose();
  }

  void _commitWithStatus(generated.UpdateCaseRequestStatusEnum status) {
    if (_title.text.trim().isEmpty || _specialty.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and specialty are required.')),
      );
      return;
    }
    final age = int.tryParse(_age.text.trim());
    if (age == null || age < 1 || age > 130) {
      setState(() => _ageError = 'Enter a valid age (1–130)');
      return;
    }
    final dxErr = validateFinalDiagnosisClient(_dx.text);
    if (dxErr != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(dxErr)));
      return;
    }
    setState(() => _ageError = null);
    Navigator.of(context).pop(
      _EditCaseDialogResult(
        title: _title.text.trim(),
        specialty: _specialty.text.trim(),
        chiefComplaint: _chief.text.trim(),
        persona: _persona.text.trim(),
        historyOfPresentIllness: _hpi.text.trim(),
        finalDiagnosis: _dx.text.trim(),
        age: age,
        difficulty: _difficulty,
        sex: _sex,
        status: status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit case',
        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.initial.caseId,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.tertiaryText,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _specialty,
                decoration: const InputDecoration(labelText: 'Specialty'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _age,
                decoration: InputDecoration(
                  labelText: 'Age',
                  errorText: _ageError,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Text(
                'Sex',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButton<generated.UpdateCaseRequestSexEnum>(
                isExpanded: true,
                value: _sex,
                items: generated.UpdateCaseRequestSexEnum.values
                    .map(
                      (v) => DropdownMenuItem(
                        value: v,
                        child: Text(v.name),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    setState(() => _sex = v);
                  }
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Difficulty',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButton<generated.UpdateCaseRequestDifficultyEnum>(
                isExpanded: true,
                value: _difficulty,
                items: generated.UpdateCaseRequestDifficultyEnum.values
                    .map(
                      (v) => DropdownMenuItem(
                        value: v,
                        child: Text(v.name),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    setState(() => _difficulty = v);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _persona,
                decoration: const InputDecoration(labelText: 'Persona'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _chief,
                decoration: const InputDecoration(labelText: 'Chief complaint'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _hpi,
                decoration: const InputDecoration(
                  labelText: 'History of present illness',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _dx,
                decoration: const InputDecoration(
                  labelText: 'Final diagnosis (ground truth, required)',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Workflow — saves all fields above',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonal(
                    onPressed: () => _commitWithStatus(
                      generated.UpdateCaseRequestStatusEnum.draft,
                    ),
                    child: Text(
                      'Save as draft',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                  FilledButton.tonal(
                    onPressed: () => _commitWithStatus(
                      generated.UpdateCaseRequestStatusEnum.review,
                    ),
                    child: Text(
                      'Send to review',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                  FilledButton(
                    onPressed: () => _commitWithStatus(
                      generated.UpdateCaseRequestStatusEnum.published,
                    ),
                    child: Text(
                      'Publish',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

generated.UpdateCaseRequestDifficultyEnum _parseUpdateDifficulty(String raw) {
  try {
    return generated.UpdateCaseRequestDifficultyEnum.valueOf(raw.toLowerCase());
  } catch (_) {
    return generated.UpdateCaseRequestDifficultyEnum.medium;
  }
}

generated.UpdateCaseRequestSexEnum _parseUpdateSex(String raw) {
  try {
    return generated.UpdateCaseRequestSexEnum.valueOf(raw.toLowerCase());
  } catch (_) {
    return generated.UpdateCaseRequestSexEnum.male;
  }
}

generated.CreateCaseRequest _createCaseRequestFromForm({
  required String caseId,
  required String title,
  required String specialty,
  required generated.CreateCaseRequestDifficultyEnum difficulty,
  required String chiefComplaint,
  required String finalDiagnosis,
}) {
  return generated.CreateCaseRequest((b) {
    b
      ..caseId = caseId
      ..title = title
      ..language = generated.CreateCaseRequestLanguageEnum.en
      ..difficulty = difficulty
      ..specialty = specialty
      ..age = 45
      ..sex = generated.CreateCaseRequestSexEnum.male
      ..persona = 'Patient presenting for evaluation.'
      ..chiefComplaint = chiefComplaint
      ..historyOfPresentIllness =
          'Further history, exam findings, and workup to be developed for this case.'
      ..finalDiagnosis = finalDiagnosis
      ..severityOrStage = null
      ..status = generated.CreateCaseRequestStatusEnum.draft;

    b.tags.add('authoring');
    b.tonePresets.add('neutral');
    b.differential.add('Differential A');
    b.differential.add('Differential B');

    b.keyHistoryPoints.mustAsk.add('Key history point 1');
    b.keyHistoryPoints.niceToAsk.add('Optional history point');
    b.keyHistoryPoints.redFlags.add('Red flag to screen');

    b.investigations.catalogHints.add('Guided workup');
    b.investigations.expected.mustOrder.add('Basic evaluation');
    b.investigations.expected.optional.add('Additional test if indicated');
    b.investigations.expected.shouldNotOrder.add('Low-value test');
    b.investigations.results.add(
      generated.InvestigationResultRequest((r) => r
        ..testName = 'Example investigation'
        ..resultType =
            generated.InvestigationResultRequestResultTypeEnum.textReport
        ..value = 'Placeholder result — replace in full case definition.'
        ..unit = null
        ..referenceRange = null),
    );

    b.management.diagnosticPlan.add('Diagnostic step 1');
    b.management.treatmentPlan.add('Treatment principle 1');
    b.management.contraindications.add('Safety consideration');
    b.management.followUp.add('Follow-up plan');

    b.scoring.weightDiagnosis = 0.35;
    b.scoring.weightDiagnostics = 0.25;
    b.scoring.weightTreatment = 0.30;
    b.scoring.weightSafety = 0.10;
    b.scoring.acceptableAnswers.add(
      generated.AcceptableAnswerRequest((a) => a
        ..field = 'final_diagnosis'
        ..answer = finalDiagnosis),
    );
    b.scoring.criticalSafetyErrors.add('Unsafe management pattern to avoid');
  });
}

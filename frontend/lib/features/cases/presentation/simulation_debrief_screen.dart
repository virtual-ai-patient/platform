import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

/// Shown after POST /sessions/{id}/finish returns 200 with status completed.
class SimulationDebriefScreen extends StatelessWidget {
  const SimulationDebriefScreen({
    super.key,
    required this.caseItem,
    required this.conclusionsResponse,
  });

  final generated.CaseResponse caseItem;
  final generated.ConclusionsResponse conclusionsResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
        title: Text(
          'Case complete',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
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
                      Icons.check_circle_rounded,
                      color: AppColors.successTeal,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Thank you, doctor.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${caseItem.caseId} · ${caseItem.title}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Session ${conclusionsResponse.sessionId} · '
                      '${conclusionsResponse.status}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const Divider(height: 32),
                    Text(
                      'Submitted conclusions',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._buildStructuredSummary(conclusionsResponse.conclusions),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: Text(
                        'Back to case library',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildStructuredSummary(
    BuiltMap<String, JsonObject?>? raw,
  ) {
    final map = _toMap(raw);
    if (map.isEmpty) {
      return [
        Text(
          'No conclusions were submitted.',
          style: GoogleFonts.inter(color: AppColors.secondaryText),
        ),
      ];
    }
    final differential = _asList(map['differential_diagnoses']);
    final finalDiagnosis = (map['final_diagnosis'] ?? '').toString().trim();
    final treatment = _asMap(map['treatment_plan']);

    final widgets = <Widget>[
      _sectionTitle('Differential Diagnoses'),
      if (differential.isEmpty)
        _muted('No differential diagnoses provided.')
      else
        ..._buildDifferentialItems(differential),
      const SizedBox(height: 14),
      _sectionTitle('Final Diagnosis'),
      Text(
        finalDiagnosis.isEmpty ? 'Not provided' : finalDiagnosis,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color:
              finalDiagnosis.isEmpty ? AppColors.danger : AppColors.primaryText,
        ),
      ),
      const SizedBox(height: 14),
      _sectionTitle('Treatment Plan'),
    ];

    widgets.addAll(_buildTreatmentPlan(treatment));
    return widgets;
  }

  static List<Widget> _buildDifferentialItems(List<dynamic> differential) {
    final normalized = differential
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList(growable: false)
      ..sort((a, b) => ((a['rank'] as num?)?.toInt() ?? 999)
          .compareTo((b['rank'] as num?)?.toInt() ?? 999));

    return normalized
        .map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlueLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${(item['rank'] as num?)?.toInt() ?? '-'}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    (item['condition'] ?? 'Unknown condition').toString(),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList(growable: false);
  }

  static List<Widget> _buildTreatmentPlan(Map<String, dynamic> treatment) {
    if (treatment.isEmpty) {
      return [_muted('No treatment plan provided.')];
    }
    final meds = _asList(treatment['medications']);
    final nonPharm = _asList(treatment['non_pharmacological'])
        .map((e) => e.toString())
        .toList(growable: false);
    final referrals = _asList(treatment['referrals'])
        .map((e) => e.toString())
        .toList(growable: false);
    final followUp = _asList(treatment['follow_up'])
        .map((e) => e.toString())
        .toList(growable: false);

    final result = <Widget>[
      if (meds.isNotEmpty) ...[
        Text('Medications',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        ...meds.whereType<Map>().map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• ${(m['name'] ?? '').toString()}'
                  '${(m['dose'] ?? '').toString().isNotEmpty ? ' — ${m['dose']}' : ''}'
                  '${(m['route'] ?? '').toString().isNotEmpty ? ' (${m['route']})' : ''}',
                  style: GoogleFonts.inter(fontSize: 13),
                ),
              ),
            ),
        const SizedBox(height: 10),
      ],
      ..._stringSection('Non-pharmacological', nonPharm),
      ..._stringSection('Referrals', referrals),
      ..._stringSection('Follow-up', followUp),
    ];
    if (result.isEmpty) {
      return [_muted('No treatment plan provided.')];
    }
    return result;
  }

  static List<Widget> _stringSection(String title, List<String> values) {
    if (values.isEmpty) return const [];
    return [
      Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
      const SizedBox(height: 6),
      ...values.map(
        (v) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text('• $v', style: GoogleFonts.inter(fontSize: 13)),
        ),
      ),
      const SizedBox(height: 10),
    ];
  }

  static Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
      );

  static Widget _muted(String text) =>
      Text(text, style: GoogleFonts.inter(color: AppColors.secondaryText));

  static Map<String, dynamic> _toMap(BuiltMap<String, JsonObject?>? raw) {
    if (raw == null || raw.isEmpty) return {};
    final out = <String, dynamic>{};
    for (final e in raw.entries) {
      out[e.key] = e.value?.value;
    }
    return out;
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return {};
  }

  static List<dynamic> _asList(dynamic value) {
    if (value is List) return value;
    return const [];
  }
}

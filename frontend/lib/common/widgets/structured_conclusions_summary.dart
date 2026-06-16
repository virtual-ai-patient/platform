import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Human-readable blocks for learner conclusions (from API `conclusions` map).
List<Widget> structuredConclusionsFromBuiltMap(
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

List<Widget> _buildDifferentialItems(List<dynamic> differential) {
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

List<Widget> _buildTreatmentPlan(Map<String, dynamic> treatment) {
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

List<Widget> _stringSection(String title, List<String> values) {
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

Widget _sectionTitle(String title) => Padding(
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

Widget _muted(String text) =>
    Text(text, style: GoogleFonts.inter(color: AppColors.secondaryText));

Map<String, dynamic> _toMap(BuiltMap<String, JsonObject?>? raw) {
  if (raw == null || raw.isEmpty) return {};
  final out = <String, dynamic>{};
  for (final e in raw.entries) {
    out[e.key] = e.value?.value;
  }
  return out;
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return {};
}

List<dynamic> _asList(dynamic value) {
  if (value is List) return value;
  return const [];
}

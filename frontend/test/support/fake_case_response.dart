import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/openapi.dart' as generated;

/// Minimal valid [CaseResponse] for widget tests.
generated.CaseResponse fakeCaseResponse() => generated.CaseResponse(
  (b) => b
    ..id = 'id-1'
    ..caseId = 'CASE-001'
    ..status = 'published'
    ..version = 1
    ..createdBy = 'educator'
    ..title = 'Test Case'
    ..language = 'en'
    ..difficulty = 'easy'
    ..specialty = 'Cardiology'
    ..tags = ListBuilder<String>(['tag1'])
    ..age = 45
    ..sex = 'male'
    ..persona = 'Test persona'
    ..tonePresets = ListBuilder<String>(['calm'])
    ..chiefComplaint = 'Chest pain'
    ..historyOfPresentIllness = 'Patient reports...'
    ..keyHistoryPoints.replace(
      generated.KeyHistoryPointsResponse(
        (k) => k
          ..mustAsk = ListBuilder<String>(['q1'])
          ..niceToAsk = ListBuilder<String>(['q2'])
          ..redFlags = ListBuilder<String>(['rf1']),
      ),
    )
    ..finalDiagnosis = 'STEMI'
    ..differential = ListBuilder<String>(['ACS'])
    ..investigations.replace(
      generated.InvestigationsResponse(
        (i) => i
          ..catalogHints = ListBuilder<String>(['ECG'])
          ..expected.replace(
            generated.ExpectedTestsResponse(
              (e) => e
                ..mustOrder = ListBuilder<String>(['ECG'])
                ..optional = ListBuilder<String>(['CXR'])
                ..shouldNotOrder = ListBuilder<String>(),
            ),
          )
          ..results = ListBuilder<generated.InvestigationResultResponse>(),
      ),
    )
    ..management.replace(
      generated.ManagementResponse(
        (m) => m
          ..diagnosticPlan = ListBuilder<String>(['ECG'])
          ..treatmentPlan = ListBuilder<String>(['Aspirin'])
          ..contraindications = ListBuilder<String>()
          ..followUp = ListBuilder<String>(['Cardiology']),
      ),
    )
    ..scoring.replace(
      generated.ScoringResponse(
        (s) => s
          ..weightDiagnosis = 0.3
          ..weightDiagnostics = 0.3
          ..weightTreatment = 0.2
          ..weightSafety = 0.2
          ..acceptableAnswers =
              ListBuilder<generated.AcceptableAnswerResponse>()
          ..criticalSafetyErrors = ListBuilder<String>(),
      ),
    ),
);

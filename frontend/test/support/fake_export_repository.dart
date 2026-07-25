import 'dart:typed_data';

import 'package:frontend/domains/analytics/export_repository.dart';

class FakeExportRepository implements ExportRepositoryContract {
  FakeExportRepository({
    this.sessionsPayload,
    this.cohortActionsPayload,
    this.sessionActionsPayload,
    this.error,
  });

  ExportPayload? sessionsPayload;
  ExportPayload? cohortActionsPayload;
  ExportPayload? sessionActionsPayload;
  Object? error;

  final calls = <String>[];

  @override
  Future<ExportPayload> exportSessions({
    required ExportFormat format,
    required String scope,
    DateTime? since,
    DateTime? until,
  }) async {
    calls.add('sessions:${format.name}:$scope');
    if (error != null) throw error!;
    return sessionsPayload ??
        ExportPayload(
          bytes: Uint8List.fromList('session,id\n'.codeUnits),
          filename: 'sessions_cohort.${format.extension}',
          mimeType: format.mimeType,
        );
  }

  @override
  Future<ExportPayload> exportCohortActions({
    required ExportFormat format,
    DateTime? since,
    DateTime? until,
  }) async {
    calls.add('cohort_actions:${format.name}');
    if (error != null) throw error!;
    return cohortActionsPayload ??
        ExportPayload(
          bytes: Uint8List.fromList('action,id\n'.codeUnits),
          filename: 'actions_cohort.${format.extension}',
          mimeType: format.mimeType,
        );
  }

  @override
  Future<ExportPayload> exportSessionActions({
    required String sessionId,
    required ExportFormat format,
  }) async {
    calls.add('session_actions:$sessionId:${format.name}');
    if (error != null) throw error!;
    return sessionActionsPayload ??
        ExportPayload(
          bytes: Uint8List.fromList('action,id\n'.codeUnits),
          filename: 'actions_session_$sessionId.${format.extension}',
          mimeType: format.mimeType,
        );
  }
}

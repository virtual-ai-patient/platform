import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:frontend/network/openapi.dart' as generated;

enum ExportFormat { csv, json }

extension ExportFormatX on ExportFormat {
  String get queryValue => name;

  String get extension => name;

  String get mimeType =>
      this == ExportFormat.csv ? 'text/csv' : 'application/json';
}

/// Result of a successful analytics export download.
class ExportPayload {
  const ExportPayload({
    required this.bytes,
    required this.filename,
    required this.mimeType,
  });

  final Uint8List bytes;
  final String filename;
  final String mimeType;
}

abstract class ExportRepositoryContract {
  /// Cohort (or personal) sessions export via `GET /analytics/export/sessions`.
  Future<ExportPayload> exportSessions({
    required ExportFormat format,
    required String scope,
    DateTime? since,
    DateTime? until,
  });

  /// Cohort actions export via `GET /analytics/export/actions` (no session_id).
  Future<ExportPayload> exportCohortActions({
    required ExportFormat format,
    DateTime? since,
    DateTime? until,
  });

  /// Per-session actions export via `GET /analytics/export/actions?session_id=`.
  Future<ExportPayload> exportSessionActions({
    required String sessionId,
    required ExportFormat format,
  });
}

/// Wraps analytics export endpoints using the shared authenticated [Dio] client.
///
/// Generated `AnalyticsApi` deserializes responses as [JsonObject], which breaks
/// CSV/streaming downloads — this repository requests bytes instead.
class ExportRepository implements ExportRepositoryContract {
  ExportRepository({required generated.Openapi openapi}) : _dio = openapi.dio;

  final Dio _dio;

  @override
  Future<ExportPayload> exportSessions({
    required ExportFormat format,
    required String scope,
    DateTime? since,
    DateTime? until,
  }) {
    return _get(
      path: '/analytics/export/sessions',
      query: {
        'format': format.queryValue,
        'scope': scope,
        if (since != null) 'since': since.toUtc().toIso8601String(),
        if (until != null) 'until': until.toUtc().toIso8601String(),
      },
      filename: _filename(
        base: 'sessions',
        scope: scope == 'all' ? 'cohort' : 'me',
        format: format,
        since: since,
        until: until,
      ),
      mimeType: format.mimeType,
    );
  }

  @override
  Future<ExportPayload> exportCohortActions({
    required ExportFormat format,
    DateTime? since,
    DateTime? until,
  }) {
    return _get(
      path: '/analytics/export/actions',
      query: {
        'format': format.queryValue,
        if (since != null) 'since': since.toUtc().toIso8601String(),
        if (until != null) 'until': until.toUtc().toIso8601String(),
      },
      filename: _filename(
        base: 'actions',
        scope: 'cohort',
        format: format,
        since: since,
        until: until,
      ),
      mimeType: format.mimeType,
    );
  }

  @override
  Future<ExportPayload> exportSessionActions({
    required String sessionId,
    required ExportFormat format,
  }) {
    return _get(
      path: '/analytics/export/actions',
      query: {'format': format.queryValue, 'session_id': sessionId},
      filename: _filename(
        base: 'actions',
        scope: 'session_$sessionId',
        format: format,
      ),
      mimeType: format.mimeType,
    );
  }

  Future<ExportPayload> _get({
    required String path,
    required Map<String, dynamic> query,
    required String filename,
    required String mimeType,
  }) async {
    final response = await _dio.get<List<int>>(
      path,
      queryParameters: query,
      options: Options(
        responseType: ResponseType.bytes,
        // OAuth interceptor reads this the same way generated clients do.
        extra: const {
          'secure': [
            {'type': 'oauth2', 'name': 'OAuth2PasswordBearer'},
          ],
        },
      ),
    );
    final data = response.data;
    if (data == null) {
      throw StateError('Empty export response from $path');
    }
    return ExportPayload(
      bytes: Uint8List.fromList(data),
      filename: filename,
      mimeType: mimeType,
    );
  }

  static String _filename({
    required String base,
    required String scope,
    required ExportFormat format,
    DateTime? since,
    DateTime? until,
  }) {
    final parts = <String>[base, scope];
    if (since != null) {
      parts.add(_day(since));
    }
    if (until != null) {
      parts.add(_day(until));
    }
    return '${parts.join('_')}.${format.extension}';
  }

  static String _day(DateTime d) {
    final u = d.toUtc();
    final m = u.month.toString().padLeft(2, '0');
    final day = u.day.toString().padLeft(2, '0');
    return '${u.year}-$m-$day';
  }
}

import 'package:dio/dio.dart';

/// Parsed 409 from POST /sessions/start when an active session already exists.
class SessionStartConflict {
  const SessionStartConflict({required this.existingSessionId, this.message});

  final String existingSessionId;
  final String? message;
}

SessionStartConflict? parseSessionStartConflict(DioException e) {
  if (e.response?.statusCode != 409) return null;
  final data = e.response?.data;
  if (data is! Map) return null;
  final detail = data['detail'];
  if (detail is Map) {
    final sid = detail['existing_session_id']?.toString();
    if (sid != null && sid.isNotEmpty) {
      return SessionStartConflict(
        existingSessionId: sid,
        message: detail['message']?.toString(),
      );
    }
  }
  return null;
}

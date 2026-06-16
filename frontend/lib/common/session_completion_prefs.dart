import 'package:shared_preferences/shared_preferences.dart';

/// Persists last completed session id per case for learner "View evaluation" in case library.
class SessionCompletionPrefs {
  SessionCompletionPrefs._();

  static const _prefix = 'completed_session_for_case_';

  static Future<void> rememberCompletedSession({
    required String caseId,
    required String sessionId,
  }) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('$_prefix$caseId', sessionId);
  }

  static Future<String?> getCompletedSessionId(String caseId) async {
    final p = await SharedPreferences.getInstance();
    return p.getString('$_prefix$caseId');
  }

  static Future<Map<String, String>> loadAll() async {
    final p = await SharedPreferences.getInstance();
    final keys = p.getKeys().where((k) => k.startsWith(_prefix));
    final out = <String, String>{};
    for (final k in keys) {
      final caseId = k.substring(_prefix.length);
      final sid = p.getString(k);
      if (sid != null && sid.isNotEmpty) {
        out[caseId] = sid;
      }
    }
    return out;
  }
}

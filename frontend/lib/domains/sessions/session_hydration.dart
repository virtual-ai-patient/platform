import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:shared_preferences/shared_preferences.dart';

/// Server state applied when resuming an active session.
class SimulationHydration {
  const SimulationHydration({
    required this.caseItem,
    required this.chatMessages,
    required this.completedTests,
    this.conclusions,
  });

  final generated.CaseResponse caseItem;
  final List<Message> chatMessages;
  final List<generated.TestResultResponse> completedTests;
  final BuiltMap<String, JsonObject?>? conclusions;
}

const doctorUserId = 'doctor';
const patientUserId = 'patient';
const systemUserId = 'system';

SimulationHydration hydrationFromSessionState(
  generated.SessionStateResponse state,
) {
  final snapshotMap = _builtMapToDynamicMap(state.caseSnapshot);
  final caseItem = generated.standardSerializers.deserialize(
    snapshotMap,
    specifiedType: const FullType(generated.CaseResponse),
  ) as generated.CaseResponse;

  final chatMessages = <Message>[];
  var seq = 0;
  for (final entry in state.chatHistory) {
    if (!_isChatRole(entry.role)) continue;
    final authorId = entry.role == 'user' ? doctorUserId : patientUserId;
    chatMessages.add(
      Message.text(
        id: 'srv-${entry.loggedAt.microsecondsSinceEpoch}-$seq',
        authorId: authorId,
        text: entry.content,
        createdAt: entry.loggedAt,
        sentAt: entry.loggedAt,
      ),
    );
    seq++;
  }

  final completedTests = state.orderedTests
      .map((name) => _reconstructTestResult(name, snapshotMap))
      .toList(growable: false);

  return SimulationHydration(
    caseItem: caseItem,
    chatMessages: chatMessages,
    completedTests: completedTests,
    conclusions: state.conclusions,
  );
}

bool _isChatRole(String role) => role == 'user' || role == 'assistant';

Map<String, dynamic> _builtMapToDynamicMap(
  BuiltMap<String, JsonObject?> map,
) {
  final out = <String, dynamic>{};
  for (final e in map.entries) {
    out[e.key] = e.value?.value;
  }
  return out;
}

generated.TestResultResponse _reconstructTestResult(
  String testName,
  Map<String, dynamic> snapshot,
) {
  final investigations = snapshot['investigations'];
  if (investigations is Map) {
    final results = investigations['results'];
    if (results is List) {
      for (final raw in results) {
        if (raw is Map && raw['test_name'] == testName) {
          return generated.TestResultResponse(
            (b) => b
              ..testName = testName
              ..resultType = (raw['result_type'] ?? 'text_report').toString()
              ..value = (raw['value'] ?? '').toString()
              ..unit = raw['unit']?.toString()
              ..referenceRange = raw['reference_range']?.toString()
              ..isNormalDefault = false,
          );
        }
      }
    }
  }
  return generated.TestResultResponse(
    (b) => b
      ..testName = testName
      ..resultType = 'text_report'
      ..value = 'Normal / No significant findings.'
      ..isNormalDefault = true,
  );
}

Future<void> persistChatMessagesToPrefs({
  required String sessionId,
  required List<Message> messages,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'chat-history-$sessionId';
  final data =
      messages.where((m) => m is TextMessage || m is SystemMessage).map((m) {
    if (m is TextMessage) {
      return <String, dynamic>{
        'type': 'text',
        'id': m.id,
        'authorId': m.authorId,
        'text': m.text,
        'createdAt': m.createdAt?.millisecondsSinceEpoch,
        'sentAt': m.sentAt?.millisecondsSinceEpoch,
        'metadata': m.metadata,
      };
    }
    final s = m as SystemMessage;
    return <String, dynamic>{
      'type': 'system',
      'id': s.id,
      'authorId': s.authorId,
      'text': s.text,
      'createdAt': s.createdAt?.millisecondsSinceEpoch,
      'metadata': s.metadata,
    };
  }).toList(growable: false);
  await prefs.setString(key, jsonEncode(data));
}

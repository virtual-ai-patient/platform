import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:built_value/serializer.dart';
import 'package:frontend/domains/sessions/session_hydration.dart';
import 'package:frontend/network/openapi.dart' as generated;

void main() {
  test('hydrationFromSessionState maps chat, tests, conclusions', () {
    final raw =
        File('test/fixtures/session_state_sample.json').readAsStringSync();
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final state = generated.standardSerializers.deserialize(
      json,
      specifiedType: const FullType(generated.SessionStateResponse),
    ) as generated.SessionStateResponse;

    final hydration = hydrationFromSessionState(state);

    expect(hydration.caseItem.caseId, 'CASE-001');
    expect(hydration.chatMessages.length, 2);
    expect(hydration.chatMessages.first.authorId, doctorUserId);
    expect(hydration.chatMessages.last.authorId, patientUserId);
    expect(hydration.completedTests.length, 1);
    expect(hydration.completedTests.first.testName, 'ECG');
    expect(hydration.completedTests.first.value, 'ST elevation');
    expect(hydration.conclusions, isNotNull);
    expect(
      hydration.conclusions!.containsKey('final_diagnosis'),
      isTrue,
    );
  });
}

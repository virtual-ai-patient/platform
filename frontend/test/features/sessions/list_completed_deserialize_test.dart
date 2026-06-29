import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/network/openapi.dart' as g;

void main() {
  test('deserializes active sessions list from API JSON', () {
    final json = [
      {
        'session_id': 'sess-1',
        'case_id': 'seed_em_stemi_001',
        'case_title': 'Test',
        'created_at': '2026-06-29T08:00:55.120640Z',
        'last_activity_at': '2026-06-29T08:01:09.709677Z',
        'progress_summary': {'turn_count': 0, 'has_conclusions': false},
      },
    ];
    final result = g.standardSerializers.deserialize(
      json,
      specifiedType: const FullType(BuiltList, [FullType(g.ActiveSessionItem)]),
    ) as BuiltList<g.ActiveSessionItem>;
    expect(result, hasLength(1));
  });

  test('deserializes completed sessions list from API JSON', () {
    final json = [
      {
        'session_id': 'c88e40f1-615f-4e12-8687-43c117082010',
        'case_id': 'seed_em_stemi_001',
        'status': 'completed',
        'created_at': '2026-06-29T08:00:55.120640Z',
        'last_activity_at': '2026-06-29T08:01:09.709677Z',
      },
    ];
    final result = g.standardSerializers.deserialize(
      json,
      specifiedType: const FullType(BuiltList, [FullType(g.SessionResponse)]),
    ) as BuiltList<g.SessionResponse>;
    expect(result, hasLength(1));
    expect(result.first.caseId, 'seed_em_stemi_001');
  });
}

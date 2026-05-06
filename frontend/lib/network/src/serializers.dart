//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:frontend/network/src/date_serializer.dart';
import 'package:frontend/network/src/model/date.dart';

import 'package:frontend/network/src/model/acceptable_answer_request.dart';
import 'package:frontend/network/src/model/acceptable_answer_response.dart';
import 'package:frontend/network/src/model/action_log_entry.dart';
import 'package:frontend/network/src/model/available_test_item.dart';
import 'package:frontend/network/src/model/available_tests_response.dart';
import 'package:frontend/network/src/model/case_response.dart';
import 'package:frontend/network/src/model/chat_request.dart';
import 'package:frontend/network/src/model/chat_response.dart';
import 'package:frontend/network/src/model/conclusions_request.dart';
import 'package:frontend/network/src/model/conclusions_response.dart';
import 'package:frontend/network/src/model/create_case_request.dart';
import 'package:frontend/network/src/model/differential_diagnosis_item.dart';
import 'package:frontend/network/src/model/expected_tests_request.dart';
import 'package:frontend/network/src/model/expected_tests_response.dart';
import 'package:frontend/network/src/model/http_validation_error.dart';
import 'package:frontend/network/src/model/investigation_result_request.dart';
import 'package:frontend/network/src/model/investigation_result_response.dart';
import 'package:frontend/network/src/model/investigations_request.dart';
import 'package:frontend/network/src/model/investigations_response.dart';
import 'package:frontend/network/src/model/key_history_points_request.dart';
import 'package:frontend/network/src/model/key_history_points_response.dart';
import 'package:frontend/network/src/model/location_inner.dart';
import 'package:frontend/network/src/model/management_request.dart';
import 'package:frontend/network/src/model/management_response.dart';
import 'package:frontend/network/src/model/medication.dart';
import 'package:frontend/network/src/model/message_response.dart';
import 'package:frontend/network/src/model/order_test_request.dart';
import 'package:frontend/network/src/model/password_reset_confirm.dart';
import 'package:frontend/network/src/model/password_reset_request.dart';
import 'package:frontend/network/src/model/refresh_request.dart';
import 'package:frontend/network/src/model/scoring_request.dart';
import 'package:frontend/network/src/model/scoring_response.dart';
import 'package:frontend/network/src/model/session_detail_response.dart';
import 'package:frontend/network/src/model/session_list_response.dart';
import 'package:frontend/network/src/model/session_response.dart';
import 'package:frontend/network/src/model/session_summary.dart';
import 'package:frontend/network/src/model/signup_request.dart';
import 'package:frontend/network/src/model/start_session_request.dart';
import 'package:frontend/network/src/model/test_result_response.dart';
import 'package:frontend/network/src/model/token_response.dart';
import 'package:frontend/network/src/model/treatment_plan.dart';
import 'package:frontend/network/src/model/update_case_request.dart';
import 'package:frontend/network/src/model/user_response.dart';
import 'package:frontend/network/src/model/validation_error.dart';

part 'serializers.g.dart';

@SerializersFor([
  AcceptableAnswerRequest,
  AcceptableAnswerResponse,
  ActionLogEntry,
  AvailableTestItem,
  AvailableTestsResponse,
  CaseResponse,
  ChatRequest,
  ChatResponse,
  ConclusionsRequest,
  ConclusionsResponse,
  CreateCaseRequest,
  DifferentialDiagnosisItem,
  ExpectedTestsRequest,
  ExpectedTestsResponse,
  HTTPValidationError,
  InvestigationResultRequest,
  InvestigationResultResponse,
  InvestigationsRequest,
  InvestigationsResponse,
  KeyHistoryPointsRequest,
  KeyHistoryPointsResponse,
  LocationInner,
  ManagementRequest,
  ManagementResponse,
  Medication,
  MessageResponse,
  OrderTestRequest,
  PasswordResetConfirm,
  PasswordResetRequest,
  RefreshRequest,
  ScoringRequest,
  ScoringResponse,
  SessionDetailResponse,
  SessionListResponse,
  SessionResponse,
  SessionSummary,
  SignupRequest,
  StartSessionRequest,
  TestResultResponse,
  TokenResponse,
  TreatmentPlan,
  UpdateCaseRequest,
  UserResponse,
  ValidationError,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(CaseResponse)]),
        () => ListBuilder<CaseResponse>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

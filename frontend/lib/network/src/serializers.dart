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

import 'package:frontend/network/src/model/http_validation_error.dart';
import 'package:frontend/network/src/model/location_inner.dart';
import 'package:frontend/network/src/model/message_response.dart';
import 'package:frontend/network/src/model/password_reset_confirm.dart';
import 'package:frontend/network/src/model/password_reset_request.dart';
import 'package:frontend/network/src/model/refresh_request.dart';
import 'package:frontend/network/src/model/signup_request.dart';
import 'package:frontend/network/src/model/token_response.dart';
import 'package:frontend/network/src/model/user_response.dart';
import 'package:frontend/network/src/model/validation_error.dart';

part 'serializers.g.dart';

@SerializersFor([
  HTTPValidationError,
  LocationInner,
  MessageResponse,
  PasswordResetConfirm,
  PasswordResetRequest,
  RefreshRequest,
  SignupRequest,
  TokenResponse,
  UserResponse,
  ValidationError,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

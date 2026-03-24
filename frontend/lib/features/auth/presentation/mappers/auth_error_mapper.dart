import 'package:dio/dio.dart';
import 'package:frontend/features/auth/presentation/models/friendly_error_data.dart';

FriendlyErrorData mapAuthError(Object error) {
  if (error is DioException) {
    if (error.type == DioExceptionType.badResponse) {
      final code = error.response?.statusCode;
      if (code == 401) {
        return const FriendlyErrorData(
          title: 'Could not sign you in',
          message:
              'Your username or password may be incorrect. Please try again or reset your password.',
          canReset: true,
        );
      }
      if (code == 422) {
        return const FriendlyErrorData(
          title: 'Please check your input',
          message:
              'Some fields look invalid. Review your data and try once more.',
        );
      }
      if (code != null && code >= 500) {
        return const FriendlyErrorData(
          title: 'Service is temporarily unavailable',
          message:
              'Our server is having trouble right now. Please retry in a few moments.',
        );
      }
    }
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const FriendlyErrorData(
        title: 'Cannot reach the server',
        message:
            'Please check your internet connection or backend availability, then try again.',
      );
    }
  }
  return const FriendlyErrorData(
    title: 'Sign in was not completed',
    message: 'Something unexpected happened. Please try again.',
  );
}

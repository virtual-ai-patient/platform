import 'package:flutter/material.dart';
import 'package:frontend/domains/admin/admin_repository.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/features/cases/presentation/case_library_screen.dart';

/// Builds the post-login root widget (library vs admin) and a factory for the login page.
class AppSessionRouter {
  const AppSessionRouter._();

  static LoginScreen loginScreen({
    required AuthRepositoryContract authRepository,
    required CaseRepositoryContract caseRepository,
    required SessionRepositoryContract sessionRepository,
    AdminRepositoryContract? adminRepository,
  }) {
    return LoginScreen(
      authRepository: authRepository,
      caseRepository: caseRepository,
      sessionRepository: sessionRepository,
      adminRepository: adminRepository,
    );
  }

  static Widget homeForSession({
    required AuthSession session,
    required AuthRepositoryContract authRepository,
    required CaseRepositoryContract caseRepository,
    required SessionRepositoryContract sessionRepository,
    AdminRepositoryContract? adminRepository,
  }) {
    LoginScreen createLoginScreen() => loginScreen(
          authRepository: authRepository,
          caseRepository: caseRepository,
          sessionRepository: sessionRepository,
          adminRepository: adminRepository,
        );
    return CaseLibraryScreen(
      session: session,
      caseRepository: caseRepository,
      sessionRepository: sessionRepository,
      authRepository: authRepository,
      adminRepository: adminRepository,
      buildLoginPage: createLoginScreen,
    );
  }
}

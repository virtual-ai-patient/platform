import 'package:flutter/material.dart';
import 'package:frontend/domains/admin/admin_repository.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/domains/evaluation/communication_repository.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/features/admin/presentation/admin_sessions_dashboard_screen.dart';
import 'package:frontend/features/cases/presentation/case_library_screen.dart';

/// Builds the post-login root widget (library vs admin) and a factory for the login page.
class AppSessionRouter {
  const AppSessionRouter._();

  static LoginScreen loginScreen({
    required AuthRepositoryContract authRepository,
    required CaseRepositoryContract caseRepository,
    required SessionRepositoryContract sessionRepository,
    required EvaluationRepositoryContract evaluationRepository,
    required CommunicationRepositoryContract communicationRepository,
    AdminRepositoryContract? adminRepository,
  }) {
    return LoginScreen(
      authRepository: authRepository,
      caseRepository: caseRepository,
      sessionRepository: sessionRepository,
      evaluationRepository: evaluationRepository,
      communicationRepository: communicationRepository,
      adminRepository: adminRepository,
    );
  }

  static Widget homeForSession({
    required AuthSession session,
    required AuthRepositoryContract authRepository,
    required CaseRepositoryContract caseRepository,
    required SessionRepositoryContract sessionRepository,
    required EvaluationRepositoryContract evaluationRepository,
    required CommunicationRepositoryContract communicationRepository,
    AdminRepositoryContract? adminRepository,
  }) {
    LoginScreen createLoginScreen() => loginScreen(
          authRepository: authRepository,
          caseRepository: caseRepository,
          sessionRepository: sessionRepository,
          evaluationRepository: evaluationRepository,
          communicationRepository: communicationRepository,
          adminRepository: adminRepository,
        );
    if (session.user.role == 'admin' && adminRepository != null) {
      return AdminSessionsDashboardScreen(
        session: session,
        adminRepository: adminRepository,
        authRepository: authRepository,
        buildLoginPage: createLoginScreen,
      );
    }
    return CaseLibraryScreen(
      session: session,
      caseRepository: caseRepository,
      sessionRepository: sessionRepository,
      evaluationRepository: evaluationRepository,
      communicationRepository: communicationRepository,
      authRepository: authRepository,
      adminRepository: adminRepository,
      buildLoginPage: createLoginScreen,
    );
  }
}

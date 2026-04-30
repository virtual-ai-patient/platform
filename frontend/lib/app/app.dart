import 'package:flutter/material.dart';
import 'package:frontend/app/app_session_router.dart';
import 'package:frontend/common/theme/app_theme.dart';
import 'package:frontend/domains/admin/admin_repository.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';

class VirtualAiPatientApp extends StatefulWidget {
  const VirtualAiPatientApp({super.key});

  @override
  State<VirtualAiPatientApp> createState() => _VirtualAiPatientAppState();
}

class _VirtualAiPatientAppState extends State<VirtualAiPatientApp> {
  late final AuthRepository _authRepository;
  late final AdminRepository _adminRepository;
  late final CaseRepository _caseRepository;
  late final SessionRepository _sessionRepository;
  Widget? _home;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(
      baseUrl: const String.fromEnvironment(
        'BACKEND_BASE_URL',
        defaultValue: 'http://localhost:8000',
      ),
    );
    _caseRepository = CaseRepository(openapi: _authRepository.openapiClient);
    _adminRepository = AdminRepository(openapi: _authRepository.openapiClient);
    _sessionRepository =
        SessionRepository(openapi: _authRepository.openapiClient);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final session = await _authRepository.restoreSession();
    if (!mounted) {
      return;
    }
    setState(() {
      _home = session == null
          ? AppSessionRouter.loginScreen(
              authRepository: _authRepository,
              caseRepository: _caseRepository,
              sessionRepository: _sessionRepository,
              adminRepository: _adminRepository,
            )
          : AppSessionRouter.homeForSession(
              session: session,
              authRepository: _authRepository,
              caseRepository: _caseRepository,
              sessionRepository: _sessionRepository,
              adminRepository: _adminRepository,
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual AI Patient',
      theme: AppTheme.light,
      home: _home ??
          const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_theme.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';

class VirtualAiPatientApp extends StatefulWidget {
  const VirtualAiPatientApp({super.key});

  @override
  State<VirtualAiPatientApp> createState() => _VirtualAiPatientAppState();
}

class _VirtualAiPatientAppState extends State<VirtualAiPatientApp> {
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(
      baseUrl: const String.fromEnvironment(
        'BACKEND_BASE_URL',
        defaultValue: 'http://localhost:8000',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual AI Patient',
      theme: AppTheme.light,
      home: LoginScreen(authRepository: _authRepository),
    );
  }
}

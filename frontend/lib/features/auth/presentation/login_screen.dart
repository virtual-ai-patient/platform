import 'package:flutter/material.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/auth/presentation/dialogs/reset_password_dialog.dart';
import 'package:frontend/features/auth/presentation/dialogs/signup_dialog.dart';
import 'package:frontend/features/auth/presentation/mappers/auth_error_mapper.dart';
import 'package:frontend/features/auth/presentation/models/friendly_error_data.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_card.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_hero_panel.dart';
import 'package:frontend/app/app_session_router.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_logo_mark.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.authRepository,
    required this.caseRepository,
    required this.sessionRepository,
  });

  final AuthRepositoryContract authRepository;
  final CaseRepositoryContract caseRepository;
  final SessionRepositoryContract sessionRepository;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  FriendlyErrorData? _error;
  bool _loading = false;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final session = await widget.authRepository.loginAndVerify(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) {
        return;
      }
      final home = AppSessionRouter.homeForSession(
        session: session,
        authRepository: widget.authRepository,
        caseRepository: widget.caseRepository,
        sessionRepository: widget.sessionRepository,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => home),
      );
    } catch (e) {
      setState(() {
        _error = mapAuthError(e);
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _openSignupDialog() {
    return showSignupDialog(
      context: context,
      authRepository: widget.authRepository,
      onPrefillCredentials: (username, password) {
        _usernameController.text = username;
        _passwordController.text = password;
      },
      onInfo: _showInfo,
    );
  }

  Future<void> _openResetDialog() {
    return showResetPasswordDialog(
      context: context,
      authRepository: widget.authRepository,
      onInfo: _showInfo,
    );
  }

  void _showInfo(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 980;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppLogoMark(
                              subtitle: 'Medical simulation training',
                            ),
                          ),
                        ),
                        isWide
                            ? IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: AuthHeroPanel(theme: theme),
                                    ),
                                    const SizedBox(width: 28),
                                    Expanded(
                                      flex: 4,
                                      child: AuthCard(
                                        usernameController: _usernameController,
                                        passwordController: _passwordController,
                                        loading: _loading,
                                        error: _error,
                                        onLogin: _login,
                                        onSignup: _openSignupDialog,
                                        onForgotPassword: _openResetDialog,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AuthHeroPanel(theme: theme),
                                  const SizedBox(height: 20),
                                  AuthCard(
                                    usernameController: _usernameController,
                                    passwordController: _passwordController,
                                    loading: _loading,
                                    error: _error,
                                    onLogin: _login,
                                    onSignup: _openSignupDialog,
                                    onForgotPassword: _openResetDialog,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

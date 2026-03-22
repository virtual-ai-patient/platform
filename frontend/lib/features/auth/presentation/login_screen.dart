import 'package:flutter/material.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/features/auth/presentation/dialogs/reset_password_dialog.dart';
import 'package:frontend/features/auth/presentation/dialogs/signup_dialog.dart';
import 'package:frontend/features/auth/presentation/mappers/auth_error_mapper.dart';
import 'package:frontend/features/auth/presentation/models/friendly_error_data.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_card.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_hero_panel.dart';
import 'package:frontend/features/home/presentation/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.authRepository,
  });

  final AuthRepositoryContract authRepository;

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen(session: session)),
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 980;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: isWide
                      ? IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5, child: AuthHeroPanel(theme: theme)),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

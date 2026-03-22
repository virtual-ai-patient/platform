import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/auth/auth_repository.dart';

Future<void> showSignupDialog({
  required BuildContext context,
  required AuthRepositoryContract authRepository,
  required void Function(String username, String password) onPrefillCredentials,
  required void Function(String message) onInfo,
}) async {
  final signupUsername = TextEditingController();
  final signupEmail = TextEditingController();
  final signupPassword = TextEditingController();
  String? localError;
  var submitting = false;

  await showDialog<void>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            title: const Text('Create account'),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: signupUsername,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: signupEmail,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: signupPassword,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  if (localError != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      localError!,
                      style: const TextStyle(color: AppColors.dangerText),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed:
                    submitting ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: submitting
                    ? null
                    : () async {
                        setModalState(() {
                          submitting = true;
                          localError = null;
                        });
                        try {
                          await authRepository.signup(
                            username: signupUsername.text.trim(),
                            email: signupEmail.text.trim(),
                            password: signupPassword.text,
                          );
                          onPrefillCredentials(
                            signupUsername.text.trim(),
                            signupPassword.text,
                          );
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.of(context).pop();
                          onInfo('Account created. You can now sign in.');
                        } catch (_) {
                          setModalState(() {
                            localError = 'Unable to create account.';
                          });
                        } finally {
                          setModalState(() {
                            submitting = false;
                          });
                        }
                      },
                child: submitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create account'),
              ),
            ],
          );
        },
      );
    },
  );

  signupUsername.dispose();
  signupEmail.dispose();
  signupPassword.dispose();
}

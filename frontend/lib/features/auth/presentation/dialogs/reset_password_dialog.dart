import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/auth/auth_repository.dart';

Future<void> showResetPasswordDialog({
  required BuildContext context,
  required AuthRepositoryContract authRepository,
  required void Function(String message) onInfo,
}) async {
  final resetEmail = TextEditingController();
  String? localError;
  var submitting = false;

  await showDialog<void>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            title: const Text('Reset password'),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter your email and we will send reset instructions.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: resetEmail,
                    decoration: const InputDecoration(labelText: 'Email'),
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
                          final message =
                              await authRepository.requestPasswordReset(
                            email: resetEmail.text.trim(),
                          );
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.of(context).pop();
                          onInfo(message);
                        } catch (_) {
                          setModalState(() {
                            localError = 'Unable to send reset instructions.';
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
                    : const Text('Send instructions'),
              ),
            ],
          );
        },
      );
    },
  );

  resetEmail.dispose();
}

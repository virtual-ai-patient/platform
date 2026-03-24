import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/features/auth/presentation/models/friendly_error_data.dart';
import 'package:frontend/features/auth/presentation/widgets/friendly_error_card.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.loading,
    required this.error,
    required this.onLogin,
    required this.onSignup,
    required this.onForgotPassword,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool loading;
  final FriendlyErrorData? error;
  final VoidCallback onLogin;
  final VoidCallback onSignup;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Sign in to continue your clinical simulation.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          if (error != null) ...[
            const SizedBox(height: 14),
            FriendlyErrorCard(
              error: error!,
              loading: loading,
              onForgotPassword: onForgotPassword,
            ),
          ],
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: loading ? null : onLogin,
            child: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Log in'),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: loading ? null : onSignup,
                child: const Text('Create account'),
              ),
              TextButton(
                onPressed: loading ? null : onForgotPassword,
                child: const Text('Forgot password?'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

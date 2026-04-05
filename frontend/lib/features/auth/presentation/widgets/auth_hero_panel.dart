import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';

class AuthHeroPanel extends StatelessWidget {
  const AuthHeroPanel({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.heroStart, AppColors.heroEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Built for medical education',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'A high-fidelity simulation platform for safe-to-fail clinical training.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.secondaryText,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 26),
          const _HeroBullet(
              text: 'Practice diagnostic reasoning with realistic cases'),
          const _HeroBullet(text: 'Receive deterministic, objective feedback'),
          const _HeroBullet(text: 'Train without patient-risk constraints'),
        ],
      ),
    );
  }
}

class _HeroBullet extends StatelessWidget {
  const _HeroBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.brandTeal, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.secondaryText),
            ),
          ),
        ],
      ),
    );
  }
}

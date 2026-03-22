import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/models/friendly_error_data.dart';

class FriendlyErrorCard extends StatelessWidget {
  const FriendlyErrorCard({
    super.key,
    required this.error,
    required this.loading,
    required this.onForgotPassword,
  });

  final FriendlyErrorData error;
  final bool loading;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 18,
                color: Color(0xFFB45309),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  error.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF92400E),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            error.message,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: const Color(0xFFB45309)),
          ),
          if (error.canReset) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: loading ? null : onForgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Reset password'),
            ),
          ],
        ],
      ),
    );
  }
}

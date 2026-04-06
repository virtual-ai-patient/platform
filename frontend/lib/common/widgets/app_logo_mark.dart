import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogoMark extends StatelessWidget {
  const AppLogoMark({
    super.key,
    this.compact = false,
    this.subtitle,
  });

  final bool compact;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 36 : 40,
          height: compact ? 36 : 40,
          decoration: BoxDecoration(
            color: AppColors.brandTeal,
            borderRadius: BorderRadius.circular(8),
          ),
          child:
              const Icon(Icons.person_rounded, color: Colors.white, size: 22),
        ),
        SizedBox(width: compact ? 10 : 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Virtual AI Patient',
                style: GoogleFonts.inter(
                  fontSize: compact ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                  height: 1.1,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

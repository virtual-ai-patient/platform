import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPageFooter extends StatelessWidget {
  const AppPageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
        color: AppColors.surface,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 8,
        children: [
          Text(
            '© ${DateTime.now().year} Virtual AI Patient',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline,
                  size: 16, color: AppColors.secondaryText),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'For educational purposes only. Not for real patient care.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Privacy',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Terms',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Support',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

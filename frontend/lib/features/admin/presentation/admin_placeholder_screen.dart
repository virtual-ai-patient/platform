import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_logo_mark.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:google_fonts/google_fonts.dart';

/// Admins do not use the case library. This screen will later host monitoring
/// for educators and learners.
class AdminPlaceholderScreen extends StatelessWidget {
  const AdminPlaceholderScreen({
    super.key,
    required this.session,
    required this.authRepository,
    required this.buildLoginPage,
  });

  final AuthSession session;
  final AuthRepositoryContract authRepository;
  final Widget Function() buildLoginPage;

  Future<void> _signOut(BuildContext context) async {
    await authRepository.logout();
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => buildLoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 8),
              child: Row(
                children: [
                  const AppLogoMark(compact: true),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _signOut(context),
                    child: Text(
                      'Sign out',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Administration',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Signed in as ${session.user.username}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Case authoring and the student library are for educator '
                          'accounts. Here you will later monitor educators and '
                          'learners across the platform.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            height: 1.5,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

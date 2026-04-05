import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_logo_mark.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLibraryTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppLibraryTopBar({
    super.key,
    required this.session,
    required this.searchController,
    this.onSignOut,
  });

  final AuthSession session;
  final TextEditingController searchController;
  final VoidCallback? onSignOut;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  String get _roleLabel {
    final r = session.user.role;
    if (r.isEmpty) return 'User';
    return '${r[0].toUpperCase()}${r.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 720;
            return Row(
              children: [
                const AppLogoMark(compact: true),
                if (!narrow) ...[
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search cases…',
                        hintStyle: GoogleFonts.inter(
                          color: AppColors.tertiaryText,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.secondaryText,
                          size: 22,
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceMuted,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(999),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.secondaryText,
                  ),
                  tooltip: 'Notifications',
                ),
                Container(
                  width: 1,
                  height: 28,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: AppColors.borderSubtle,
                ),
                Flexible(
                  flex: 0,
                  fit: FlexFit.loose,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: narrow ? 120 : 220,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Text(
                        session.user.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                      Text(
                        _roleLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primaryBlueLight,
                  child: Text(
                    session.user.username.isNotEmpty
                        ? session.user.username[0].toUpperCase()
                        : '?',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                if (onSignOut != null) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onSignOut,
                    child: Text(
                      'Sign out',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

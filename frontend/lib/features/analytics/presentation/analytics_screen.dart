import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_logo_mark.dart';
import 'package:frontend/domains/analytics/export_repository.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/features/analytics/presentation/export_controls.dart';
import 'package:google_fonts/google_fonts.dart';

/// Educator/admin analytics surface with date-window filters and Export.
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({
    super.key,
    required this.session,
    required this.exportRepository,
  });

  final AuthSession session;
  final ExportRepositoryContract exportRepository;

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  DateTime? _since;
  DateTime? _until;

  bool get _canExport {
    final role = widget.session.user.role.toLowerCase();
    return role == 'educator' || role == 'admin';
  }

  Future<void> _pickSince() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _since ?? DateTime.now().subtract(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(
        () => _since = DateTime.utc(picked.year, picked.month, picked.day),
      );
    }
  }

  Future<void> _pickUntil() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _until ?? DateTime.now(),
    );
    if (picked != null) {
      setState(
        () => _until = DateTime.utc(
          picked.year,
          picked.month,
          picked.day,
          23,
          59,
          59,
        ),
      );
    }
  }

  String _label(DateTime? d, String empty) {
    if (d == null) return empty;
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }

  @override
  Widget build(BuildContext context) {
    if (!_canExport) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: const Center(
          child: Text('Analytics export is available to educators and admins.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
        title: const AppLogoMark(compact: true, subtitle: 'Analytics export'),
        actions: [
          AnalyticsExportMenuButton(
            exportRepository: widget.exportRepository,
            since: _since,
            until: _until,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Export cohort data',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose an optional time window, then use Export to download '
                  'sessions or action logs for the full cohort.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _pickSince,
                      icon: const Icon(Icons.calendar_today_outlined, size: 18),
                      label: Text('Since: ${_label(_since, 'any')}'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _pickUntil,
                      icon: const Icon(Icons.event_outlined, size: 18),
                      label: Text('Until: ${_label(_until, 'any')}'),
                    ),
                    if (_since != null || _until != null)
                      TextButton(
                        onPressed: () => setState(() {
                          _since = null;
                          _until = null;
                        }),
                        child: const Text('Clear dates'),
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 0,
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.borderSubtle),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available downloads',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• Sessions (CSV / JSON)\n'
                          '• Actions — this cohort (CSV / JSON)',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            height: 1.5,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AnalyticsExportMenuButton(
                          exportRepository: widget.exportRepository,
                          since: _since,
                          until: _until,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

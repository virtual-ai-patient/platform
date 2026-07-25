import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/browser_file_download.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/analytics/export_repository.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared export trigger: loading overlay + SnackBar errors (incl. 403).
Future<void> runAnalyticsExport({
  required BuildContext context,
  required Future<ExportPayload> Function() request,
  BrowserFileSaver? fileSaver,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Preparing download…'),
            ],
          ),
        ),
      ),
    ),
  );

  try {
    final payload = await request();
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    (fileSaver ?? saveBrowserFile)(
      bytes: payload.bytes,
      filename: payload.filename,
      mimeType: payload.mimeType,
    );
    messenger.showSnackBar(
      SnackBar(content: Text('Downloaded ${payload.filename}')),
    );
  } on DioException catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.danger,
        content: Text(_exportErrorMessage(e)),
      ),
    );
  } catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.danger,
        content: Text('Export failed: $e'),
      ),
    );
  }
}

String _exportErrorMessage(DioException e) {
  final code = e.response?.statusCode;
  final detail = _detail(e);
  if (code == 403) {
    return detail ?? 'You do not have permission to export this data.';
  }
  if (code == 401) {
    return 'Session expired. Sign in again and retry the export.';
  }
  if (code == 404) {
    return detail ?? 'Export target not found.';
  }
  return detail ?? e.message ?? 'Export failed (${code ?? 'network error'}).';
}

String? _detail(DioException e) {
  final data = e.response?.data;
  if (data is Map && data['detail'] != null) {
    return data['detail'].toString();
  }
  if (data is List<int>) {
    try {
      final text = String.fromCharCodes(data);
      if (text.contains('detail')) return text;
    } catch (_) {}
  }
  return null;
}

/// Popup menu used on the analytics screen (educator / admin cohort exports).
class AnalyticsExportMenuButton extends StatelessWidget {
  const AnalyticsExportMenuButton({
    super.key,
    required this.exportRepository,
    this.since,
    this.until,
    this.fileSaver,
  });

  final ExportRepositoryContract exportRepository;
  final DateTime? since;
  final DateTime? until;
  final BrowserFileSaver? fileSaver;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Export',
      onSelected: (value) {
        runAnalyticsExport(
          context: context,
          fileSaver: fileSaver,
          request: () => _request(value),
        );
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'sessions_csv', child: Text('Sessions (CSV)')),
        PopupMenuItem(value: 'sessions_json', child: Text('Sessions (JSON)')),
        PopupMenuItem(
          value: 'actions_csv',
          child: Text('Actions — this cohort (CSV)'),
        ),
        PopupMenuItem(
          value: 'actions_json',
          child: Text('Actions — this cohort (JSON)'),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.download_rounded, size: 20),
            const SizedBox(width: 6),
            Text(
              'Export',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Future<ExportPayload> _request(String value) {
    switch (value) {
      case 'sessions_csv':
        return exportRepository.exportSessions(
          format: ExportFormat.csv,
          scope: 'all',
          since: since,
          until: until,
        );
      case 'sessions_json':
        return exportRepository.exportSessions(
          format: ExportFormat.json,
          scope: 'all',
          since: since,
          until: until,
        );
      case 'actions_csv':
        return exportRepository.exportCohortActions(
          format: ExportFormat.csv,
          since: since,
          until: until,
        );
      case 'actions_json':
        return exportRepository.exportCohortActions(
          format: ExportFormat.json,
          since: since,
          until: until,
        );
      default:
        throw StateError('Unknown export option: $value');
    }
  }
}

/// Per-session actions export on the debrief screen.
class SessionActionsExportButton extends StatelessWidget {
  const SessionActionsExportButton({
    super.key,
    required this.sessionId,
    required this.exportRepository,
    this.fileSaver,
  });

  final String sessionId;
  final ExportRepositoryContract exportRepository;
  final BrowserFileSaver? fileSaver;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExportFormat>(
      tooltip: 'Export actions',
      onSelected: (format) {
        runAnalyticsExport(
          context: context,
          fileSaver: fileSaver,
          request: () => exportRepository.exportSessionActions(
            sessionId: sessionId,
            format: format,
          ),
        );
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: ExportFormat.csv, child: Text('Actions (CSV)')),
        PopupMenuItem(value: ExportFormat.json, child: Text('Actions (JSON)')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.file_download_outlined, size: 20),
            const SizedBox(width: 4),
            Text(
              'Export actions',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

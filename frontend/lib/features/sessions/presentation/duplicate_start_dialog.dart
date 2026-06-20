import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/domains/sessions/session_start_conflict.dart';
import 'package:frontend/features/cases/presentation/case_simulation_screen.dart';
import 'package:frontend/features/sessions/presentation/resume_session_flow.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

/// Shown when POST /sessions/start returns 409 for an existing active session.
Future<void> showDuplicateStartDialog({
  required BuildContext context,
  required generated.CaseResponse caseItem,
  required SessionStartConflict conflict,
  required SessionRepositoryContract sessionRepository,
  required EvaluationRepositoryContract evaluationRepository,
}) async {
  await showDialog<void>(
    context: context,
    builder: (ctx) => _DuplicateStartDialog(
      caseItem: caseItem,
      conflict: conflict,
      sessionRepository: sessionRepository,
      evaluationRepository: evaluationRepository,
    ),
  );
}

class _DuplicateStartDialog extends StatefulWidget {
  const _DuplicateStartDialog({
    required this.caseItem,
    required this.conflict,
    required this.sessionRepository,
    required this.evaluationRepository,
  });

  final generated.CaseResponse caseItem;
  final SessionStartConflict conflict;
  final SessionRepositoryContract sessionRepository;
  final EvaluationRepositoryContract evaluationRepository;

  @override
  State<_DuplicateStartDialog> createState() => _DuplicateStartDialogState();
}

class _DuplicateStartDialogState extends State<_DuplicateStartDialog> {
  bool _resumeBusy = false;
  bool _freshBusy = false;
  String? _error;

  Future<void> _resumeExisting() async {
    setState(() {
      _resumeBusy = true;
      _error = null;
    });
    final root = context;
    Navigator.of(root).pop();
    await resumeSessionAndNavigate(
      context: root,
      sessionId: widget.conflict.existingSessionId,
      sessionRepository: widget.sessionRepository,
      evaluationRepository: widget.evaluationRepository,
    );
  }

  Future<void> _startFresh() async {
    setState(() {
      _freshBusy = true;
      _error = null;
    });
    try {
      final res = await widget.sessionRepository.startSession(
        caseId: widget.caseItem.caseId,
        force: true,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => CaseSimulationScreen(
            caseItem: widget.caseItem,
            sessionId: res.sessionId,
            sessionRepository: widget.sessionRepository,
            evaluationRepository: widget.evaluationRepository,
          ),
        ),
      );
    } on DioException catch (e) {
      if (!mounted) return;
      final code = e.response?.statusCode;
      setState(() {
        _error = switch (code) {
          403 => 'You cannot start this case.',
          404 => 'Case not found.',
          _ => 'Could not start a new session.',
        };
        _freshBusy = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'Could not start a new session.';
          _freshBusy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Unfinished session',
        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You already have an unfinished session for this case.',
            style: GoogleFonts.inter(fontSize: 14),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: GoogleFonts.inter(color: AppColors.danger, fontSize: 13),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: (_resumeBusy || _freshBusy)
              ? null
              : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: (_resumeBusy || _freshBusy) ? null : _resumeExisting,
          child: _resumeBusy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Resume existing'),
        ),
        FilledButton(
          onPressed: (_resumeBusy || _freshBusy) ? null : _startFresh,
          child: _freshBusy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Start fresh'),
        ),
      ],
    );
  }
}

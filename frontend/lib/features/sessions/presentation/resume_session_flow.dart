import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/domains/sessions/session_hydration.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/cases/presentation/case_simulation_screen.dart';
import 'package:google_fonts/google_fonts.dart';

/// Fetches full session state, then navigates to [CaseSimulationScreen].
Future<void> resumeSessionAndNavigate({
  required BuildContext context,
  required String sessionId,
  required SessionRepositoryContract sessionRepository,
  required EvaluationRepositoryContract evaluationRepository,
}) async {
  if (!context.mounted) return;
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const PopScope(
      canPop: false,
      child: Center(child: CircularProgressIndicator()),
    ),
  );

  try {
    final state = await sessionRepository.fetchFullState(sessionId: sessionId);
    if (!context.mounted) return;
    Navigator.of(context).pop();
    final hydration = hydrationFromSessionState(state);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CaseSimulationScreen(
          caseItem: hydration.caseItem,
          sessionId: sessionId,
          sessionRepository: sessionRepository,
          evaluationRepository: evaluationRepository,
          initialHydration: hydration,
        ),
      ),
    );
  } on DioException catch (e) {
    if (!context.mounted) return;
    Navigator.of(context).pop();
    final code = e.response?.statusCode;
    final message = switch (code) {
      403 => 'You do not have access to this session.',
      404 => 'Session not found.',
      _ => 'Could not load session state. Check your connection and try again.',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: GoogleFonts.inter())),
    );
  } catch (_) {
    if (!context.mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Could not resume session.',
          style: GoogleFonts.inter(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/cases/presentation/case_simulation_screen.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

class CaseBriefingScreen extends StatefulWidget {
  const CaseBriefingScreen({
    super.key,
    required this.caseItem,
    required this.sessionRepository,
  });

  final generated.CaseResponse caseItem;
  final SessionRepositoryContract sessionRepository;

  @override
  State<CaseBriefingScreen> createState() => _CaseBriefingScreenState();
}

class _CaseBriefingScreenState extends State<CaseBriefingScreen> {
  bool _starting = false;

  Future<void> _startSimulation() async {
    setState(() => _starting = true);
    try {
      final res = await widget.sessionRepository.startSession(
        caseId: widget.caseItem.caseId,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => CaseSimulationScreen(
            caseItem: widget.caseItem,
            sessionId: res.sessionId,
            sessionRepository: widget.sessionRepository,
          ),
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not start session. The server may be unreachable.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.caseItem;
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
        title: Text(
          'Case briefing',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Material(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.borderSubtle),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      c.title,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      c.caseId,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.tertiaryText,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Chief complaint',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      c.chiefComplaint,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        height: 1.45,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '${c.specialty} · ${c.difficulty} · age ${c.age}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 28),
                    FilledButton(
                      onPressed: _starting ? null : _startSimulation,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _starting
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Start simulation',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Creates a server session for this case and opens the AI chat.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColors.tertiaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

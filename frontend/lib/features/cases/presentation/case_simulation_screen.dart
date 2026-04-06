import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_logo_mark.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

/// Simulation shell (chat + sidebar). UI is illustrative until messaging is wired.
class CaseSimulationScreen extends StatefulWidget {
  const CaseSimulationScreen({
    super.key,
    required this.caseItem,
  });

  final generated.CaseResponse caseItem;

  @override
  State<CaseSimulationScreen> createState() => _CaseSimulationScreenState();
}

class _CaseSimulationScreenState extends State<CaseSimulationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.caseItem;
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      body: Column(
        children: [
          _SimulationHeader(caseItem: c),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 960;
                final sidebar = _SimulationSidebar(
                  tabController: _tabController,
                  caseItem: c,
                );
                final chat = _SimulationChatArea(
                  caseItem: c,
                  inputController: _inputController,
                );
                if (wide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 3, child: chat),
                      SizedBox(width: 320, child: sidebar),
                    ],
                  );
                }
                return Column(
                  children: [
                    Expanded(child: chat),
                    SizedBox(height: 260, child: sidebar),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SimulationHeader extends StatelessWidget {
  const _SimulationHeader({
    required this.caseItem,
  });

  final generated.CaseResponse caseItem;

  @override
  Widget build(BuildContext context) {
    final sexAbb = caseItem.sex.isNotEmpty ? caseItem.sex[0].toUpperCase() : '';
    return Material(
      color: AppColors.surface,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              color: AppColors.primaryText,
            ),
            const AppLogoMark(
              compact: true,
              subtitle: 'Medical Training Simulation',
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${caseItem.caseId} · ${caseItem.title}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Text(
                    '${caseItem.age}$sexAbb',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E6),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEA580C),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Anxious',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9A3412),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.schedule_rounded,
                    size: 18, color: AppColors.secondaryText),
                const SizedBox(width: 4),
                Text(
                  '12:34',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.danger,
                side: const BorderSide(color: Color(0xFFFECACA)),
                backgroundColor: AppColors.dangerSoftBg,
              ),
              icon: const Icon(Icons.stop_rounded, size: 18),
              label: Text(
                'End Case',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimulationChatArea extends StatelessWidget {
  const _SimulationChatArea({
    required this.caseItem,
    required this.inputController,
  });

  final generated.CaseResponse caseItem;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: AppColors.canvasBackground,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _PatientBubble(
                  name: 'Virtual patient',
                  time: '09:15',
                  text: caseItem.chiefComplaint.isNotEmpty
                      ? caseItem.chiefComplaint
                      : 'Hello doctor, I am not feeling well.',
                ),
                const SizedBox(height: 16),
                const _DoctorBubble(
                  time: '09:16',
                  text:
                      'Thank you for sharing. Can you tell me when this started?',
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          color: AppColors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _SuggestionChip(label: 'Onset details'),
                    const SizedBox(width: 8),
                    _SuggestionChip(label: 'Radiation pattern'),
                    const SizedBox(width: 8),
                    _SuggestionChip(label: 'Associated symptoms'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                        hintText: 'Type your question or response…',
                        filled: true,
                        fillColor: AppColors.surfaceMuted,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(999),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: const Icon(Icons.send_rounded, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: const BorderSide(color: AppColors.primaryBlue),
        backgroundColor: AppColors.primaryBlueLight,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _PatientBubble extends StatelessWidget {
  const _PatientBubble({
    required this.name,
    required this.time,
    required this.text,
  });

  final String name;
  final String time;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.successTeal,
          child:
              const Icon(Icons.person_rounded, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name (Patient)  $time',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.patientBubbleBg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.45,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DoctorBubble extends StatelessWidget {
  const _DoctorBubble({
    required this.time,
    required this.text,
  });

  final String time;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$time  You (Doctor)',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: AppColors.doctorBubbleBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.45,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primaryBlue,
          child: const Icon(Icons.medical_services_rounded,
              color: Colors.white, size: 18),
        ),
      ],
    );
  }
}

class _SimulationSidebar extends StatelessWidget {
  const _SimulationSidebar({
    required this.tabController,
    required this.caseItem,
  });

  final TabController tabController;
  final generated.CaseResponse caseItem;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: AppColors.borderSubtle)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              controller: tabController,
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: AppColors.secondaryText,
              indicatorColor: AppColors.primaryBlue,
              labelStyle:
                  GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
              tabs: const [
                Tab(text: 'Patient Summary'),
                Tab(text: 'Orders'),
                Tab(text: 'Notes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _SummaryTab(caseItem: caseItem),
                  const _PlaceholderTab(text: 'Orders will appear here.'),
                  const _PlaceholderTab(text: 'Your notes will appear here.'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.successTeal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.assignment_outlined, size: 20),
                label: Text(
                  'Order Investigations',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTab extends StatelessWidget {
  const _SummaryTab({required this.caseItem});

  final generated.CaseResponse caseItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Chief complaint',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          caseItem.chiefComplaint,
          style:
              GoogleFonts.inter(fontSize: 13, color: AppColors.secondaryText),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.warningBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.warningBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: AppColors.danger, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Review red flags and key history points in the full case definition.',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.primaryText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: AppColors.secondaryText),
        ),
      ),
    );
  }
}

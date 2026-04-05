import 'package:flutter/material.dart';
import 'package:frontend/common/theme/app_colors.dart';
import 'package:frontend/common/widgets/app_library_top_bar.dart';
import 'package:frontend/common/widgets/app_page_footer.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/features/cases/presentation/case_briefing_screen.dart';
import 'package:frontend/features/cases/presentation/educator_case_manage_panel.dart';
import 'package:frontend/network/openapi.dart' as generated;
import 'package:google_fonts/google_fonts.dart';

enum _LibraryMainTab { browse, manage }

class CaseLibraryScreen extends StatefulWidget {
  const CaseLibraryScreen({
    super.key,
    required this.session,
    required this.caseRepository,
    required this.authRepository,
    required this.buildLoginPage,
  });

  final AuthSession session;
  final CaseRepositoryContract caseRepository;
  final AuthRepositoryContract authRepository;
  final Widget Function() buildLoginPage;

  @override
  State<CaseLibraryScreen> createState() => _CaseLibraryScreenState();
}

class _CaseLibraryScreenState extends State<CaseLibraryScreen> {
  final _searchController = TextEditingController();
  Future<List<generated.CaseResponse>>? _load;
  final Set<String> _specialtyFilters = {};
  final Set<String> _difficultyFilters = {};
  final Set<String> _statusFilters = {};
  int _sortIndex = 0;
  bool _gridView = true;
  int _page = 0;
  static const _pageSize = 6;
  _LibraryMainTab _mainTab = _LibraryMainTab.browse;
  bool _manageEditMode = false;
  String? _managingCaseId;
  bool _creatingCase = false;

  bool get _isCaseManager => widget.session.user.role == 'educator';

  bool get _canFilterStatus => _isCaseManager;

  @override
  void initState() {
    super.initState();
    _load = widget.caseRepository.listCases();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {
      _load = widget.caseRepository.listCases();
      _page = 0;
    });
    await _load;
  }

  Future<void> _signOut() async {
    await widget.authRepository.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => widget.buildLoginPage()),
      (_) => false,
    );
  }

  List<generated.CaseResponse> _applyFilters(List<generated.CaseResponse> all) {
    final q = _searchController.text.trim().toLowerCase();
    var list = all.where((c) {
      if (q.isNotEmpty) {
        final hay = '${c.title} ${c.caseId} ${c.specialty} ${c.chiefComplaint}'
            .toLowerCase();
        if (!hay.contains(q)) return false;
      }
      if (_specialtyFilters.isNotEmpty &&
          !_specialtyFilters.contains(c.specialty)) {
        return false;
      }
      if (_difficultyFilters.isNotEmpty &&
          !_difficultyFilters.contains(c.difficulty.toLowerCase())) {
        return false;
      }
      if (_canFilterStatus &&
          _statusFilters.isNotEmpty &&
          !_statusFilters.contains(c.status.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    switch (_sortIndex) {
      case 0:
        break;
      case 1:
        list = [...list]..sort((a, b) => a.title.compareTo(b.title));
      case 2:
        list = [...list]..sort((a, b) => a.difficulty.compareTo(b.difficulty));
    }
    return list;
  }

  Set<String> _specialtiesFrom(List<generated.CaseResponse> all) {
    return all.map((c) => c.specialty).toSet()..removeWhere((s) => s.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      body: Column(
        children: [
          AppLibraryTopBar(
            session: widget.session,
            searchController: _searchController,
            onSignOut: _signOut,
          ),
          Expanded(
            child: FutureBuilder<List<generated.CaseResponse>>(
              future: _load,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return _ErrorBody(
                    message: 'Could not load cases.',
                    detail: '${snapshot.error}',
                    onRetry: _refresh,
                  );
                }
                final all = snapshot.data ?? [];
                final filtered = _applyFilters(all);
                final specialties = _specialtiesFrom(all);

                void openBriefing(generated.CaseResponse c) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => CaseBriefingScreen(caseItem: c),
                    ),
                  );
                }

                final isManageTab =
                    _isCaseManager && _mainTab == _LibraryMainTab.manage;

                Future<void> educatorNewCase() => runEducatorCreateCaseFlow(
                      context,
                      caseRepository: widget.caseRepository,
                      onRefresh: _refresh,
                      onWorking: (w) {
                        if (mounted) {
                          setState(() => _creatingCase = w);
                        }
                      },
                    );

                Future<void> educatorEdit(generated.CaseResponse c) =>
                    runEducatorEditCaseFlow(
                      context,
                      initial: c,
                      caseRepository: widget.caseRepository,
                      onRefresh: _refresh,
                      onWorking: (w) {
                        if (mounted) {
                          setState(() => _managingCaseId = w ? c.id : null);
                        }
                      },
                    );

                Future<void> educatorDelete(generated.CaseResponse c) =>
                    runEducatorDeleteCaseFlow(
                      context,
                      c: c,
                      caseRepository: widget.caseRepository,
                      onRefresh: _refresh,
                      onWorking: (w) {
                        if (mounted) {
                          setState(() => _managingCaseId = w ? c.id : null);
                        }
                      },
                    );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_isCaseManager)
                      _CaseManagerTabBar(
                        selected: _mainTab,
                        onSelect: (t) => setState(() {
                          _mainTab = t;
                          if (t == _LibraryMainTab.browse) {
                            _manageEditMode = false;
                          }
                        }),
                      ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final showDrawer = constraints.maxWidth < 900;
                          final filterPane = _FilterPane(
                      specialties: specialties.toList()..sort(),
                      specialtyFilters: _specialtyFilters,
                      difficultyFilters: _difficultyFilters,
                      statusFilters: _statusFilters,
                      showStatus: _canFilterStatus,
                      onClear: () => setState(() {
                        _specialtyFilters.clear();
                        _difficultyFilters.clear();
                        _statusFilters.clear();
                      }),
                      onSpecialtyToggle: (s) => setState(() {
                        if (_specialtyFilters.contains(s)) {
                          _specialtyFilters.remove(s);
                        } else {
                          _specialtyFilters.add(s);
                        }
                        _page = 0;
                      }),
                      onDifficultyToggle: (d) => setState(() {
                        if (_difficultyFilters.contains(d)) {
                          _difficultyFilters.remove(d);
                        } else {
                          _difficultyFilters.add(d);
                        }
                        _page = 0;
                      }),
                      onStatusToggle: (s) => setState(() {
                        if (_statusFilters.contains(s)) {
                          _statusFilters.remove(s);
                        } else {
                          _statusFilters.add(s);
                        }
                        _page = 0;
                      }),
                    );

                    if (showDrawer) {
                      return RefreshIndicator(
                        color: AppColors.primaryBlue,
                        onRefresh: _refresh,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search cases…',
                                    prefixIcon:
                                        const Icon(Icons.search_rounded),
                                    filled: true,
                                    fillColor: AppColors.surfaceMuted,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(999),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: ExpansionTile(
                                title: Text(
                                  'FILTERS',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: filterPane,
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: _MainPane(
                                filtered: filtered,
                                gridView: _gridView,
                                sortIndex: _sortIndex,
                                page: _page,
                                pageSize: _pageSize,
                                onSort: (i) => setState(() => _sortIndex = i),
                                onToggleView: () =>
                                    setState(() => _gridView = !_gridView),
                                onPage: (p) => setState(() => _page = p),
                                onOpenCase: openBriefing,
                                isManageTab: isManageTab,
                                manageEditMode: _manageEditMode,
                                onManageEditModeChanged: (v) =>
                                    setState(() => _manageEditMode = v),
                                creatingCase: _creatingCase,
                                onEducatorNewCase: educatorNewCase,
                                managingCaseId: _managingCaseId,
                                onEducatorEdit: educatorEdit,
                                onEducatorDelete: educatorDelete,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: AppColors.primaryBlue,
                      onRefresh: _refresh,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 260,
                            child: SingleChildScrollView(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 12, 20),
                              child: filterPane,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.fromLTRB(12, 20, 20, 20),
                              child: _MainPane(
                                filtered: filtered,
                                gridView: _gridView,
                                sortIndex: _sortIndex,
                                page: _page,
                                pageSize: _pageSize,
                                onSort: (i) => setState(() => _sortIndex = i),
                                onToggleView: () =>
                                    setState(() => _gridView = !_gridView),
                                onPage: (p) => setState(() => _page = p),
                                onOpenCase: openBriefing,
                                isManageTab: isManageTab,
                                manageEditMode: _manageEditMode,
                                onManageEditModeChanged: (v) =>
                                    setState(() => _manageEditMode = v),
                                creatingCase: _creatingCase,
                                onEducatorNewCase: educatorNewCase,
                                managingCaseId: _managingCaseId,
                                onEducatorEdit: educatorEdit,
                                onEducatorDelete: educatorDelete,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
              },
            ),
          ),
          const AppPageFooter(),
        ],
      ),
    );
  }
}

class _CaseManagerTabBar extends StatelessWidget {
  const _CaseManagerTabBar({
    required this.selected,
    required this.onSelect,
  });

  final _LibraryMainTab selected;
  final ValueChanged<_LibraryMainTab> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderSubtle),
          ),
        ),
        child: Row(
          children: [
            _tab(context, 'Browse library', _LibraryMainTab.browse),
            const SizedBox(width: 4),
            _tab(context, 'Manage cases', _LibraryMainTab.manage),
          ],
        ),
      ),
    );
  }

  Widget _tab(BuildContext context, String label, _LibraryMainTab tab) {
    final isOn = selected == tab;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onSelect(tab),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: isOn ? FontWeight.w700 : FontWeight.w500,
                color: isOn ? AppColors.primaryBlue : AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 2,
              width: isOn ? 72 : 0,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterPane extends StatelessWidget {
  const _FilterPane({
    required this.specialties,
    required this.specialtyFilters,
    required this.difficultyFilters,
    required this.statusFilters,
    required this.showStatus,
    required this.onClear,
    required this.onSpecialtyToggle,
    required this.onDifficultyToggle,
    required this.onStatusToggle,
  });

  final List<String> specialties;
  final Set<String> specialtyFilters;
  final Set<String> difficultyFilters;
  final Set<String> statusFilters;
  final bool showStatus;
  final VoidCallback onClear;
  final void Function(String) onSpecialtyToggle;
  final void Function(String) onDifficultyToggle;
  final void Function(String) onStatusToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'FILTERS',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 1,
                color: AppColors.primaryText,
              ),
            ),
            TextButton(
              onPressed: onClear,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Clear all',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _FilterSection(
          title: 'Specialty',
          child: Column(
            children: specialties
                .map(
                  (s) => CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: specialtyFilters.contains(s),
                    onChanged: (_) => onSpecialtyToggle(s),
                    title: Text(
                      s,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        _FilterSection(
          title: 'Difficulty',
          child: Column(
            children: [
              _difficultyRow('easy', 'Beginner', AppColors.difficultyEasy),
              _difficultyRow(
                  'medium', 'Intermediate', AppColors.difficultyMedium),
              _difficultyRow('hard', 'Advanced', AppColors.difficultyHard),
            ],
          ),
        ),
        if (showStatus)
          _FilterSection(
            title: 'Status',
            child: Column(
              children: ['draft', 'review', 'published']
                  .map(
                    (s) => CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: statusFilters.contains(s),
                      onChanged: (_) => onStatusToggle(s),
                      title: Text(
                        s[0].toUpperCase() + s.substring(1),
                        style: GoogleFonts.inter(fontSize: 13),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _difficultyRow(String key, String label, Color color) {
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      value: difficultyFilters.contains(key),
      onChanged: (_) => onDifficultyToggle(key),
      title: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _MainPane extends StatelessWidget {
  const _MainPane({
    required this.filtered,
    required this.gridView,
    required this.sortIndex,
    required this.page,
    required this.pageSize,
    required this.onSort,
    required this.onToggleView,
    required this.onPage,
    required this.onOpenCase,
    this.isManageTab = false,
    this.manageEditMode = false,
    this.onManageEditModeChanged,
    this.creatingCase = false,
    this.onEducatorNewCase,
    this.managingCaseId,
    this.onEducatorEdit,
    this.onEducatorDelete,
  });

  final List<generated.CaseResponse> filtered;
  final bool gridView;
  final int sortIndex;
  final int page;
  final int pageSize;
  final void Function(int) onSort;
  final VoidCallback onToggleView;
  final void Function(int) onPage;
  final void Function(generated.CaseResponse) onOpenCase;
  final bool isManageTab;
  final bool manageEditMode;
  final ValueChanged<bool>? onManageEditModeChanged;
  final bool creatingCase;
  final Future<void> Function()? onEducatorNewCase;
  final String? managingCaseId;
  final Future<void> Function(generated.CaseResponse)? onEducatorEdit;
  final Future<void> Function(generated.CaseResponse)? onEducatorDelete;

  @override
  Widget build(BuildContext context) {
    final totalPages = (filtered.length / pageSize).ceil().clamp(1, 999);
    final safePage = page.clamp(0, totalPages - 1);
    final start = safePage * pageSize;
    final pageItems = filtered.skip(start).take(pageSize).toList();
    final showCardActions = isManageTab && manageEditMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isManageTab ? 'Manage cases' : 'Case Library',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isManageTab
                        ? 'Same view as Browse — filter, preview, then use Edit on the cards to change or remove cases.'
                        : 'Practice clinical workflows with AI-powered virtual patients',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            _SortDropdown(
              valueIndex: sortIndex,
              onChanged: onSort,
            ),
            const SizedBox(width: 12),
            ToggleButtons(
              isSelected: [gridView, !gridView],
              onPressed: (i) {
                if ((i == 0) != gridView) onToggleView();
              },
              borderRadius: BorderRadius.circular(8),
              borderColor: AppColors.borderSubtle,
              selectedBorderColor: AppColors.primaryBlue,
              selectedColor: AppColors.primaryBlue,
              color: AppColors.secondaryText,
              fillColor: AppColors.primaryBlueLight,
              constraints: const BoxConstraints(minWidth: 44, minHeight: 36),
              children: const [
                Icon(Icons.grid_view_rounded, size: 20),
                Icon(Icons.view_list_rounded, size: 20),
              ],
            ),
          ],
        ),
        if (isManageTab &&
            onManageEditModeChanged != null &&
            onEducatorNewCase != null) ...[
          const SizedBox(height: 20),
          EducatorManageToolbar(
            editMode: manageEditMode,
            onEditModeChanged: onManageEditModeChanged!,
            creatingCase: creatingCase,
            onNewCase: () => onEducatorNewCase!(),
          ),
        ],
        const SizedBox(height: 24),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Center(
              child: Text(
                'No cases match your filters.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.secondaryText,
                ),
              ),
            ),
          )
        else if (gridView)
          LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              int cols = 1;
              if (w > 1100) {
                cols = 3;
              } else if (w > 640) {
                cols = 2;
              }
              final spacing = 16.0;
              final tileW = (w - spacing * (cols - 1)) / cols;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: pageItems
                    .map(
                      (item) => SizedBox(
                        width: tileW,
                        child: _LibraryCaseCard(
                          caseItem: item,
                          onStart: () => onOpenCase(item),
                          showManageActions: showCardActions,
                          actionBusy: managingCaseId == item.id,
                          onEdit: onEducatorEdit == null
                              ? null
                              : () => onEducatorEdit!(item),
                          onDelete: onEducatorDelete == null
                              ? null
                              : () => onEducatorDelete!(item),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          )
        else
          Column(
            children: pageItems
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _LibraryCaseCard(
                      caseItem: item,
                      compact: true,
                      onStart: () => onOpenCase(item),
                      showManageActions: showCardActions,
                      actionBusy: managingCaseId == item.id,
                      onEdit: onEducatorEdit == null
                          ? null
                          : () => onEducatorEdit!(item),
                      onDelete: onEducatorDelete == null
                          ? null
                          : () => onEducatorDelete!(item),
                    ),
                  ),
                )
                .toList(),
          ),
        if (filtered.isNotEmpty) ...[
          const SizedBox(height: 28),
          _PaginationBar(
            page: safePage,
            totalPages: totalPages,
            onPage: onPage,
          ),
        ],
      ],
    );
  }
}

class _SortDropdown extends StatelessWidget {
  const _SortDropdown({
    required this.valueIndex,
    required this.onChanged,
  });

  final int valueIndex;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderSubtle),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.surface,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: valueIndex.clamp(0, 2),
          items: [
            DropdownMenuItem(
              value: 0,
              child: Text(
                'Sort by: Recommended',
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text(
                'Sort by: Title',
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text(
                'Sort by: Difficulty',
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _PaginationBar extends StatelessWidget {
  const _PaginationBar({
    required this.page,
    required this.totalPages,
    required this.onPage,
  });

  final int page;
  final int totalPages;
  final void Function(int) onPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: page > 0 ? () => onPage(page - 1) : null,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Page ${page + 1} of $totalPages',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
            ),
          ),
        ),
        IconButton(
          onPressed: page < totalPages - 1 ? () => onPage(page + 1) : null,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

Color _caseWorkflowStatusColor(String s) {
  switch (s.toLowerCase()) {
    case 'published':
      return AppColors.difficultyEasy;
    case 'review':
      return AppColors.difficultyMedium;
    default:
      return AppColors.secondaryText;
  }
}

class _LibraryCaseCard extends StatelessWidget {
  const _LibraryCaseCard({
    required this.caseItem,
    required this.onStart,
    this.compact = false,
    this.showManageActions = false,
    this.actionBusy = false,
    this.onEdit,
    this.onDelete,
  });

  final generated.CaseResponse caseItem;
  final VoidCallback onStart;
  final bool compact;
  final bool showManageActions;
  final bool actionBusy;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  Color get _difficultyColor {
    switch (caseItem.difficulty.toLowerCase()) {
      case 'easy':
        return AppColors.difficultyEasy;
      case 'medium':
        return AppColors.difficultyMedium;
      case 'hard':
        return AppColors.difficultyHard;
      default:
        return AppColors.secondaryText;
    }
  }

  String get _difficultyLabel {
    switch (caseItem.difficulty.toLowerCase()) {
      case 'easy':
        return 'Beginner';
      case 'medium':
        return 'Intermediate';
      case 'hard':
        return 'Advanced';
      default:
        return caseItem.difficulty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = caseItem.chiefComplaint;
    final short =
        summary.length > 140 ? '${summary.substring(0, 140)}…' : summary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _difficultyLabel,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _difficultyColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      caseItem.specialty,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.specialtyAccent,
                      ),
                    ),
                  ],
                ),
              ),
              if (showManageActions)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _caseWorkflowStatusColor(caseItem.status)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    caseItem.status[0].toUpperCase() +
                        caseItem.status.substring(1).toLowerCase(),
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _caseWorkflowStatusColor(caseItem.status),
                    ),
                  ),
                )
              else
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border_rounded,
                    color: AppColors.secondaryText,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            caseItem.title,
            style: GoogleFonts.inter(
              fontSize: compact ? 16 : 17,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            short,
            maxLines: compact ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 13,
              height: 1.4,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: caseItem.tags.take(5).map((t) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.chipBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  t,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.secondaryText,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          if (showManageActions) ...[
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
                children: [
                  TextButton(
                    onPressed: actionBusy || onEdit == null
                        ? null
                        : onEdit,
                    child: Text(
                      'Edit',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: actionBusy || onDelete == null
                        ? null
                        : onDelete,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.danger,
                    ),
                    child: Text(
                      'Delete',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  if (actionBusy)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
          Row(
            children: [
              Icon(Icons.schedule_rounded,
                  size: 16, color: AppColors.tertiaryText),
              const SizedBox(width: 4),
              Text(
                '~${(caseItem.age / 10).ceil() * 5} min',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.tertiaryText,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.signal_cellular_alt_rounded,
                  size: 16, color: _difficultyColor),
              const SizedBox(width: 4),
              Text(
                _difficultyLabel,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.tertiaryText,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: actionBusy ? null : onStart,
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Start Case',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    required this.message,
    required this.detail,
    required this.onRetry,
  });

  final String message;
  final String detail;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(32),
      children: [
        Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.danger,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          detail,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}

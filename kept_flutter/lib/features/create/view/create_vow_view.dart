import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../features/vows/domain/vow_codes.dart';
import '../../../product/init/language/localization.dart';
import '../../../product/utility/layout/kept_breakpoints.dart';
import '../../../product/components/vow_room_card.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/utility/constants/kept_day.dart';
import '../../../product/components/kept_native.dart';
import '../../../product/components/kept_widgets.dart';
import '../../../product/init/dependency/dependency_items.dart';
import '../../../product/service/vow_repository.dart';
import '../../auth/view/sign_in_sheet.dart';

part 'widgets/category_chip.dart';
part 'widgets/choice_bar.dart';
part 'widgets/examples.dart';
part 'widgets/preview.dart';

class CreateVowView extends ConsumerStatefulWidget {
  const CreateVowView({
    super.key,
    this.asTab = false,
    this.onCreated,
  });

  /// When true, renders as a bottom-nav tab (no back AppBar).
  final bool asTab;

  /// Called after a successful create when [asTab] is true.
  final ValueChanged<VowRoom>? onCreated;

  @override
  ConsumerState<CreateVowView> createState() => _CreateVowViewState();
}

class _CreateVowViewState extends ConsumerState<CreateVowView> {
  VowRepository get _repo => ref.read(vowRepositoryProvider);
  final _title = TextEditingController();
  final _rule = TextEditingController();
  String _category = VowCategory.health;
  String _joinPolicy = VowPolicy.open;
  int _length = VowLength.threeWeeks;
  bool _startsTomorrow = true;
  int? _example;
  bool _filling = false;
  bool _saving = false;
  String? _error;

  static const _lengths = [
    VowLength.week,
    VowLength.threeWeeks,
    VowLength.open,
  ];

  @override
  void initState() {
    super.initState();
    _title.addListener(_onDraftChanged);
    _rule.addListener(_onDraftChanged);
  }

  void _onDraftChanged() {
    if (_filling || !mounted || _example == null) return;
    setState(() => _example = null);
  }

  void _useDraft(int index) {
    final draft = _drafts(context.l10n)[index];
    _filling = true;
    _title.text = draft.title;
    _rule.text = draft.rule;
    _filling = false;
    setState(() {
      _example = index;
      _category = draft.category;
    });
  }

  String get _startsOn {
    final now = DateTime.now();
    return _startsTomorrow
        ? KeptDay.key(now.add(const Duration(days: 1)))
        : KeptDay.key(now);
  }

  List<(String, String)> _categories(BuildContext context) {
    final l10n = context.l10n;
    return [
      (VowCategory.health, l10n.categoryHealth),
      (VowCategory.quit, l10n.categoryQuit),
      (VowCategory.move, l10n.categoryMove),
      (VowCategory.focus, l10n.categoryFocus),
      (VowCategory.custom, l10n.categoryCustom),
    ];
  }

  List<(String, String, String)> _policies(BuildContext context) {
    final l10n = context.l10n;
    return [
      (VowPolicy.open, l10n.policyOpenLabel, l10n.policyOpenHelp),
      (VowPolicy.approval, l10n.policyApprovalLabel, l10n.policyApprovalHelp),
      (VowPolicy.invite, l10n.policyInviteLabel, l10n.policyInviteHelp),
      (VowPolicy.closed, l10n.policyClosedLabel, l10n.policyClosedHelp),
    ];
  }

  @override
  void dispose() {
    _title.dispose();
    _rule.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!client.auth.isAuthenticated) {
      final ok = await showSignInSheet(context);
      if (!ok || !mounted) return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final room = await _repo.createRoom(
        title: _title.text,
        rule: _rule.text,
        category: _category,
        joinPolicy: _joinPolicy,
        durationDays: _length,
        startsOn: _startsOn,
      );
      if (!mounted) return;
      _title.clear();
      _rule.clear();
      setState(() {
        _category = VowCategory.health;
        _joinPolicy = VowPolicy.open;
        _length = VowLength.threeWeeks;
        _startsTomorrow = true;
        _example = null;
      });
      if (widget.asTab) {
        widget.onCreated?.call(room);
      } else {
        Navigator.of(context).pop(room);
      }
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = LayoutBuilder(
      builder: (context, constraints) {
        final sidePad = constraints.maxWidth > KeptBreakpoints.contentMax
            ? (constraints.maxWidth - KeptBreakpoints.contentMax) / 2
            : 0.0;
        return ListView(
          padding: EdgeInsets.fromLTRB(
            22 + sidePad,
            widget.asTab ? 18 : 8,
            22 + sidePad,
            40,
          ),
          children: [
            if (widget.asTab) ...[
              Text(
                'KEPT',
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.5,
                  color: KeptTheme.accent,
                ),
              ),
              const SizedBox(height: 10),
            ],
            Text(
              context.l10n.makeANewVow,
              style: GoogleFonts.sora(
                fontSize: widget.asTab ? 30 : 28,
                fontWeight: FontWeight.w700,
                height: 1.15,
                color: context.kept.paper,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.createLead,
              style: GoogleFonts.manrope(
                color: context.kept.mist,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 28),
            _ExampleList(selected: _example, onSelect: _useDraft),
            const SizedBox(height: 22),
            Text(
              context.l10n.fieldTitle,
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _title,
              style: TextStyle(color: context.kept.paper),
              decoration: _inputDecoration(context.l10n.titleHint),
            ),
            const SizedBox(height: 18),
            Text(
              context.l10n.fieldRule,
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _rule,
              maxLines: 3,
              style: TextStyle(color: context.kept.paper),
              decoration: _inputDecoration(context.l10n.ruleHint),
            ),
            const SizedBox(height: 18),
            Text(
              context.l10n.fieldCategory,
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in _categories(context))
                  _CategoryChip(
                    label: c.$2,
                    selected: _category == c.$1,
                    onSelected: () => setState(() => _category = c.$1),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              context.l10n.fieldLength,
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            _ChoiceBar(
              labels: [
                context.l10n.durationWeek,
                context.l10n.durationThreeWeeks,
                context.l10n.durationOpen,
              ],
              selectedIndex: _lengths.indexOf(_length).clamp(0, 2),
              onChanged: (i) => setState(() => _length = _lengths[i]),
            ),
            const SizedBox(height: 22),
            Text(
              context.l10n.fieldStart,
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            _ChoiceBar(
              labels: [context.l10n.startsToday, context.l10n.startsTomorrow],
              selectedIndex: _startsTomorrow ? 1 : 0,
              onChanged: (i) => setState(() => _startsTomorrow = i == 1),
            ),
            const SizedBox(height: 8),
            Text(
              _startsTomorrow
                  ? context.l10n.startTomorrowHelp
                  : context.l10n.startTodayHelp,
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: context.kept.mist,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              context.l10n.whoCanJoin,
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            if (keptUsesNativeCupertino) ...[
              SizedBox(
                height: 36,
                width: double.infinity,
                child: CNSegmentedControl(
                  labels: _policies(context).map((p) => p.$2).toList(),
                  selectedIndex: () {
                    final i = _policies(
                      context,
                    ).indexWhere((p) => p.$1 == _joinPolicy);
                    return i < 0 ? 0 : i;
                  }(),
                  height: 36,
                  color: KeptTheme.accent,
                  onValueChanged: (i) {
                    final policies = _policies(context);
                    if (i < 0 || i >= policies.length) return;
                    setState(() => _joinPolicy = policies[i].$1);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _policies(context).firstWhere((p) => p.$1 == _joinPolicy).$3,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: context.kept.mist,
                ),
              ),
              const SizedBox(height: 12),
            ] else
              ..._policies(context).map((p) {
                final selected = _joinPolicy == p.$1;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => _joinPolicy = p.$1),
                      borderRadius: BorderRadius.circular(14),
                      child: Ink(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: context.kept.panel,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? KeptTheme.accent.withValues(alpha: 0.55)
                                : context.kept.line,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              selected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: selected
                                  ? KeptTheme.accent
                                  : context.kept.mist,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.$2,
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w700,
                                      color: context.kept.paper,
                                    ),
                                  ),
                                  Text(
                                    p.$3,
                                    style: GoogleFonts.manrope(
                                      fontSize: 12,
                                      color: context.kept.mist,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            const SizedBox(height: 8),
            _VowPreview(
              title: _title.text,
              rule: _rule.text,
              category: _category,
              joinPolicy: _joinPolicy,
              durationDays: _length,
              startsTomorrow: _startsTomorrow,
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: TextStyle(color: KeptTheme.broke)),
            ],
            const SizedBox(height: 28),
            KeptPrimaryButton(
              label: _saving ? context.l10n.creating : context.l10n.createVow,
              onPressed: _saving ? null : _submit,
            ),
          ],
        );
      },
    );

    if (widget.asTab) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [context.kept.wash, context.kept.void_],
          ),
        ),
        child: SafeArea(bottom: false, child: body),
      );
    }

    return Scaffold(
      backgroundColor: context.kept.void_,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: context.kept.paper,
        title: Text(
          context.l10n.newVow,
          style: GoogleFonts.sora(fontWeight: FontWeight.w600),
        ),
      ),
      body: body,
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: context.kept.mist),
      filled: true,
      fillColor: context.kept.panel,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: context.kept.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: KeptTheme.accent),
      ),
    );
  }
}

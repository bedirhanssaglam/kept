import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../features/vows/domain/vow_codes.dart';
import '../../../product/brand/kept_brand.dart';
import '../../../product/utility/layout/kept_breakpoints.dart';
import '../../../product/components/vow_room_card.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/utility/constants/kept_day.dart';
import '../../../product/components/kept_native.dart';
import '../../../product/components/kept_widgets.dart';
import '../../../product/service/vow_repository.dart';
import '../../auth/view/sign_in_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

part 'create_vow_form.dart';
part 'widgets/category_chip.dart';
part 'widgets/choice_bar.dart';
part 'widgets/examples.dart';
part 'widgets/join_policy.dart';
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

class _CreateVowViewState extends ConsumerState<CreateVowView>
    with CreateVowForm {
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
                KeptBrand.mark,
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
              LocaleKeys.makeANewVow.tr(),
              style: GoogleFonts.sora(
                fontSize: widget.asTab ? 30 : 28,
                fontWeight: FontWeight.w700,
                height: 1.15,
                color: context.kept.paper,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.createLead.tr(),
              style: GoogleFonts.manrope(
                color: context.kept.mist,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 28),
            _ExampleList(selected: _example, onSelect: _useDraft),
            const SizedBox(height: 22),
            Text(
              LocaleKeys.fieldTitle.tr(),
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _title,
              style: TextStyle(color: context.kept.paper),
              decoration: _inputDecoration(LocaleKeys.titleHint.tr()),
            ),
            const SizedBox(height: 18),
            Text(
              LocaleKeys.fieldRule.tr(),
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _rule,
              maxLines: 3,
              style: TextStyle(color: context.kept.paper),
              decoration: _inputDecoration(LocaleKeys.ruleHint.tr()),
            ),
            const SizedBox(height: 18),
            Text(
              LocaleKeys.fieldCategory.tr(),
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in _categories)
                  _CategoryChip(
                    label: category.label,
                    selected: _category == category.value,
                    onSelected: () =>
                        setState(() => _category = category.value),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              LocaleKeys.fieldLength.tr(),
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            _ChoiceBar(
              labels: [
                LocaleKeys.durationWeek.tr(),
                LocaleKeys.durationThreeWeeks.tr(),
                LocaleKeys.durationOpen.tr(),
              ],
              selectedIndex: CreateVowForm.lengths.indexOf(_length).clamp(0, 2),
              onChanged: (i) =>
                  setState(() => _length = CreateVowForm.lengths[i]),
            ),
            const SizedBox(height: 22),
            Text(
              LocaleKeys.fieldStart.tr(),
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            _ChoiceBar(
              labels: [
                LocaleKeys.startsToday.tr(),
                LocaleKeys.startsTomorrow.tr(),
              ],
              selectedIndex: _startsTomorrow ? 1 : 0,
              onChanged: (i) => setState(() => _startsTomorrow = i == 1),
            ),
            const SizedBox(height: 8),
            Text(
              _startsTomorrow
                  ? LocaleKeys.startTomorrowHelp.tr()
                  : LocaleKeys.startTodayHelp.tr(),
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: context.kept.mist,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              LocaleKeys.whoCanJoin.tr(),
              style: GoogleFonts.manrope(color: context.kept.mist),
            ),
            const SizedBox(height: 10),
            _JoinPolicyPicker(
              policies: _policies,
              selected: _joinPolicy,
              onChanged: (value) => setState(() => _joinPolicy = value),
            ),
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
              label: _saving
                  ? LocaleKeys.creating.tr()
                  : LocaleKeys.createVow.tr(),
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
          LocaleKeys.newVow.tr(),
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

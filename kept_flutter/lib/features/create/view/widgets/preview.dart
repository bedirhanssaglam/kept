part of '../create_vow_view.dart';

class _VowPreview extends StatelessWidget {
  const _VowPreview({
    required this.title,
    required this.rule,
    required this.category,
    required this.joinPolicy,
    required this.durationDays,
    required this.startsTomorrow,
  });

  final String title;
  final String rule;
  final String category;
  final String joinPolicy;
  final int durationDays;
  final bool startsTomorrow;

  @override
  Widget build(BuildContext context) {
    final trimmedTitle = title.trim();
    final trimmedRule = rule.trim();
    final startsOn = startsTomorrow
        ? KeptDay.key(DateTime.now().add(const Duration(days: 1)))
        : KeptDay.key();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.previewLead.tr(),
          style: GoogleFonts.manrope(color: context.kept.mist),
        ),
        const SizedBox(height: 10),
        VowRoomCard(
          title: trimmedTitle.isEmpty
              ? LocaleKeys.previewEmptyTitle.tr()
              : trimmedTitle,
          rule: trimmedRule.isEmpty
              ? LocaleKeys.previewEmptyRule.tr()
              : trimmedRule,
          category: category,
          joinPolicy: joinPolicy,
          memberCount: 1,
          durationDays: durationDays,
          startsOn: startsOn,
          showEnter: false,
          quiet: trimmedTitle.isEmpty,
        ),
      ],
    );
  }
}

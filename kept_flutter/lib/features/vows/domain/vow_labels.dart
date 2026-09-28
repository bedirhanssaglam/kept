import '../../../product/init/language/app_strings.dart';
import '../../../product/utility/constants/kept_day.dart';
import 'vow_codes.dart';

bool vowHasStarted(String startsOn, String today) {
  if (startsOn.isEmpty) return true;
  return today.compareTo(startsOn) >= 0;
}

bool vowHasEnded(String startsOn, int durationDays, String today) {
  if (durationDays <= 0 || startsOn.isEmpty) return false;
  return today.compareTo(shiftDayKey(startsOn, durationDays - 1)) > 0;
}

String shiftDayKey(String key, int days) {
  final parts = key.split('-');
  final date = DateTime(
    int.parse(parts[0]),
    int.parse(parts[1]),
    int.parse(parts[2]),
  ).add(Duration(days: days));
  return KeptDay.key(date);
}

String vowLengthLabel(AppStrings l10n, int days) {
  return switch (days) {
    VowLength.week => l10n.durationWeek,
    VowLength.threeWeeks => l10n.durationThreeWeeks,
    _ => l10n.durationOpen,
  };
}

/// A start line only while the first day is still ahead.
String? vowUpcomingStart(AppStrings l10n, String startsOn, String today) {
  if (startsOn.isEmpty || today.compareTo(startsOn) >= 0) return null;
  if (startsOn == shiftDayKey(today, 1)) return l10n.startsTomorrowLabel;
  return l10n.startsOnDay(startsOn);
}

String vowSpanLine(
  AppStrings l10n, {
  required int durationDays,
  required String startsOn,
  String? today,
}) {
  final day = today ?? KeptDay.key();
  if (vowHasEnded(startsOn, durationDays, day)) return l10n.vowFinished;
  final length = vowLengthLabel(l10n, durationDays);
  final start = vowUpcomingStart(l10n, startsOn, day);
  if (start == null) return length;
  return '$length · $start';
}

String vowCategoryLabel(AppStrings l10n, String category) {
  return switch (category) {
    VowCategory.health => l10n.categoryHealth,
    VowCategory.quit => l10n.categoryQuit,
    VowCategory.move => l10n.categoryMove,
    VowCategory.focus => l10n.categoryFocus,
    _ => l10n.categoryCustom,
  };
}

String vowPolicyShort(AppStrings l10n, String policy) {
  return switch (policy) {
    VowPolicy.approval => l10n.policyApprovalShort,
    VowPolicy.invite => l10n.policyInviteShort,
    VowPolicy.closed => l10n.policyClosedShort,
    _ => l10n.policyOpen,
  };
}

String vowPolicyChip(AppStrings l10n, String policy) {
  return switch (policy) {
    VowPolicy.approval => l10n.policyApproval,
    VowPolicy.invite => l10n.policyInvite,
    VowPolicy.closed => l10n.policyClosed,
    _ => l10n.policyOpenToJoin,
  };
}

String vowRoleLabel(AppStrings l10n, String role) {
  return switch (role) {
    VowRole.owner => l10n.roleOwner,
    VowRole.admin => l10n.roleAdmin,
    _ => l10n.roleMember,
  };
}

String vowDayStatus(AppStrings l10n, bool? kept) {
  if (kept == null) return l10n.statusQuiet;
  return kept ? l10n.statusKept : l10n.statusBroke;
}

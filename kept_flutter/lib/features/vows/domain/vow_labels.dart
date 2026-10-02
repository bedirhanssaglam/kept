import 'package:easy_localization/easy_localization.dart';

import '../../../product/utility/constants/kept_day.dart';
import '../../../product/init/language/locale_keys.g.dart';
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

String vowLengthLabel(int days) {
  return switch (days) {
    VowLength.week => LocaleKeys.durationWeek.tr(),
    VowLength.threeWeeks => LocaleKeys.durationThreeWeeks.tr(),
    _ => LocaleKeys.durationOpen.tr(),
  };
}

/// A start line only while the first day is still ahead.
String? vowUpcomingStart(String startsOn, String today) {
  if (startsOn.isEmpty || today.compareTo(startsOn) >= 0) return null;
  if (startsOn == shiftDayKey(today, 1)) {
    return LocaleKeys.startsTomorrowLabel.tr();
  }
  return LocaleKeys.startsOnDay.tr(namedArgs: {'day': startsOn});
}

String vowSpanLine({
  required int durationDays,
  required String startsOn,
  String? today,
}) {
  final day = today ?? KeptDay.key();
  if (vowHasEnded(startsOn, durationDays, day)) {
    return LocaleKeys.vowFinished.tr();
  }
  final length = vowLengthLabel(durationDays);
  final start = vowUpcomingStart(startsOn, day);
  if (start == null) return length;
  return '$length · $start';
}

String vowCategoryLabel(String category) {
  return switch (category) {
    VowCategory.health => LocaleKeys.categoryHealth.tr(),
    VowCategory.quit => LocaleKeys.categoryQuit.tr(),
    VowCategory.move => LocaleKeys.categoryMove.tr(),
    VowCategory.focus => LocaleKeys.categoryFocus.tr(),
    _ => LocaleKeys.categoryCustom.tr(),
  };
}

String vowPolicyShort(String policy) {
  return switch (policy) {
    VowPolicy.approval => LocaleKeys.policyApprovalShort.tr(),
    VowPolicy.invite => LocaleKeys.policyInviteShort.tr(),
    VowPolicy.closed => LocaleKeys.policyClosedShort.tr(),
    _ => LocaleKeys.policyOpen.tr(),
  };
}

String vowPolicyChip(String policy) {
  return switch (policy) {
    VowPolicy.approval => LocaleKeys.policyApproval.tr(),
    VowPolicy.invite => LocaleKeys.policyInvite.tr(),
    VowPolicy.closed => LocaleKeys.policyClosed.tr(),
    _ => LocaleKeys.policyOpenToJoin.tr(),
  };
}

String vowRoleLabel(String role) {
  return switch (role) {
    VowRole.owner => LocaleKeys.roleOwner.tr(),
    VowRole.admin => LocaleKeys.roleAdmin.tr(),
    _ => LocaleKeys.roleMember.tr(),
  };
}

String vowDayStatus(bool? kept) {
  if (kept == null) return LocaleKeys.statusQuiet.tr();
  return kept ? LocaleKeys.statusKept.tr() : LocaleKeys.statusBroke.tr();
}

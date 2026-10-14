import 'package:easy_localization/easy_localization.dart';

import '../../../product/utility/constants/kept_day.dart';
import '../../../product/init/language/locale_keys.g.dart';
import 'vow_codes.dart';

abstract final class VowLabels {
  static bool hasStarted(String startsOn, String today) {
    if (startsOn.isEmpty) return true;
    return today.compareTo(startsOn) >= 0;
  }

  static bool hasEnded(String startsOn, int durationDays, String today) {
    if (durationDays <= 0 || startsOn.isEmpty) return false;
    return today.compareTo(_shiftDay(startsOn, durationDays - 1)) > 0;
  }

  static String length(int days) {
    return switch (days) {
      VowLength.week => LocaleKeys.durationWeek.tr(),
      VowLength.threeWeeks => LocaleKeys.durationThreeWeeks.tr(),
      _ => LocaleKeys.durationOpen.tr(),
    };
  }

  /// A start line only while the first day is still ahead.
  static String? upcomingStart(String startsOn, String today) {
    if (startsOn.isEmpty || today.compareTo(startsOn) >= 0) return null;
    if (startsOn == _shiftDay(today, 1)) {
      return LocaleKeys.startsTomorrowLabel.tr();
    }
    return LocaleKeys.startsOnDay.tr(namedArgs: {'day': startsOn});
  }

  static String span({
    required int durationDays,
    required String startsOn,
    String? today,
  }) {
    final day = today ?? KeptDay.key();
    if (hasEnded(startsOn, durationDays, day)) {
      return LocaleKeys.vowFinished.tr();
    }
    final lengthLabel = length(durationDays);
    final start = upcomingStart(startsOn, day);
    if (start == null) return lengthLabel;
    return '$lengthLabel · $start';
  }

  static String category(String category) {
    return switch (category) {
      VowCategory.health => LocaleKeys.categoryHealth.tr(),
      VowCategory.quit => LocaleKeys.categoryQuit.tr(),
      VowCategory.move => LocaleKeys.categoryMove.tr(),
      VowCategory.focus => LocaleKeys.categoryFocus.tr(),
      _ => LocaleKeys.categoryCustom.tr(),
    };
  }

  static String policyShort(String policy) {
    return switch (policy) {
      VowPolicy.approval => LocaleKeys.policyApprovalShort.tr(),
      VowPolicy.invite => LocaleKeys.policyInviteShort.tr(),
      VowPolicy.closed => LocaleKeys.policyClosedShort.tr(),
      _ => LocaleKeys.policyOpen.tr(),
    };
  }

  static String policyChip(String policy) {
    return switch (policy) {
      VowPolicy.approval => LocaleKeys.policyApproval.tr(),
      VowPolicy.invite => LocaleKeys.policyInvite.tr(),
      VowPolicy.closed => LocaleKeys.policyClosed.tr(),
      _ => LocaleKeys.policyOpenToJoin.tr(),
    };
  }

  static String role(String role) {
    return switch (role) {
      VowRole.owner => LocaleKeys.roleOwner.tr(),
      VowRole.admin => LocaleKeys.roleAdmin.tr(),
      _ => LocaleKeys.roleMember.tr(),
    };
  }

  static String dayStatus(bool? kept) {
    if (kept == null) return LocaleKeys.statusQuiet.tr();
    return kept ? LocaleKeys.statusKept.tr() : LocaleKeys.statusBroke.tr();
  }

  static String _shiftDay(String key, int days) {
    final parts = key.split('-');
    final date = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    ).add(Duration(days: days));
    return KeptDay.key(date);
  }
}

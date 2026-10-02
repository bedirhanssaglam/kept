import 'package:easy_localization/easy_localization.dart';

import '../../features/vows/domain/vow_codes.dart';
import '../init/language/locale_keys.g.dart';

/// System lines are stored in English. The UI rebuilds them from [kind]
/// so the visible sentence follows the selected language.
String activityLine({
  required String kind,
  required String name,
  required String body,
}) {
  switch (kind) {
    case VowActivityKind.kept:
    case VowActivityKind.broke:
      final note = _note(body);
      final kept = kind == VowActivityKind.kept;
      if (note == null) {
        return kept
            ? LocaleKeys.activityKept.tr(namedArgs: {'name': name})
            : LocaleKeys.activityBroke.tr(namedArgs: {'name': name});
      }
      return kept
          ? LocaleKeys.activityKeptNote.tr(
              namedArgs: {'name': name, 'note': note},
            )
          : LocaleKeys.activityBrokeNote.tr(
              namedArgs: {'name': name, 'note': note},
            );
    case VowActivityKind.joined:
      if (body.contains(ActivityBody.created)) {
        return LocaleKeys.activityCreated.tr(namedArgs: {'name': name});
      }
      return LocaleKeys.activityJoined.tr(namedArgs: {'name': name});
    default:
      return body;
  }
}

abstract final class ActivityBody {
  static const created = 'created this vow';
  static const noteSeparator = ' — ';
}

String? _note(String body) {
  const separator = ActivityBody.noteSeparator;
  final index = body.indexOf(separator);
  if (index < 0) return null;
  final note = body.substring(index + separator.length).trim();
  return note.isEmpty ? null : note;
}

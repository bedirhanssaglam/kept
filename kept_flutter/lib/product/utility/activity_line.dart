import '../../features/vows/domain/vow_codes.dart';
import '../init/language/app_strings.dart';

/// System lines are stored in English. The UI rebuilds them from [kind]
/// so the visible sentence follows the selected language.
String activityLine(
  AppStrings l10n, {
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
        return kept ? l10n.activityKept(name) : l10n.activityBroke(name);
      }
      return kept
          ? l10n.activityKeptNote(name, note)
          : l10n.activityBrokeNote(name, note);
    case VowActivityKind.joined:
      if (body.contains(ActivityBody.created)) {
        return l10n.activityCreated(name);
      }
      return l10n.activityJoined(name);
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

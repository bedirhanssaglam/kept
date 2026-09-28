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
    case 'kept':
    case 'broke':
      final note = _note(body);
      final kept = kind == 'kept';
      if (note == null) {
        return kept ? l10n.activityKept(name) : l10n.activityBroke(name);
      }
      return kept
          ? l10n.activityKeptNote(name, note)
          : l10n.activityBrokeNote(name, note);
    case 'joined':
      if (body.contains('created this vow')) return l10n.activityCreated(name);
      return l10n.activityJoined(name);
    default:
      return body;
  }
}

String? _note(String body) {
  const separator = ' — ';
  final index = body.indexOf(separator);
  if (index < 0) return null;
  final note = body.substring(index + separator.length).trim();
  return note.isEmpty ? null : note;
}

part of '../room_view.dart';

class _InviteCodeDialog extends StatefulWidget {
  const _InviteCodeDialog({this.code});

  final String? code;

  static Future<String?> ask(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) => const _InviteCodeDialog(),
    );
  }

  static Future<void> show(BuildContext context, String code) {
    return showDialog<void>(
      context: context,
      builder: (context) => _InviteCodeDialog(code: code),
    );
  }

  @override
  State<_InviteCodeDialog> createState() => _InviteCodeDialogState();
}

class _InviteCodeDialogState extends State<_InviteCodeDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = widget.code;
    return AlertDialog(
      backgroundColor: context.kept.panel,
      title: Text(
        LocaleKeys.inviteCode.tr(),
        style: GoogleFonts.sora(color: context.kept.paper),
      ),
      content: code == null
          ? TextField(
              controller: _controller,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              style: TextStyle(color: context.kept.paper),
              decoration: InputDecoration(
                hintText: LocaleKeys.inviteHint.tr(),
                hintStyle: TextStyle(color: context.kept.mist),
              ),
            )
          : SelectableText(
              code,
              style: GoogleFonts.sora(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: KeptTheme.accent,
                letterSpacing: 2,
              ),
            ),
      actions: [
        if (code == null)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(LocaleKeys.cancel.tr()),
          ),
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            code == null ? _controller.text.trim() : null,
          ),
          child: Text(
            code == null ? LocaleKeys.join.tr() : LocaleKeys.done.tr(),
          ),
        ),
      ],
    );
  }
}

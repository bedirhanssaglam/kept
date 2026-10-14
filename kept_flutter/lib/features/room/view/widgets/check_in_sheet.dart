part of '../room_view.dart';

class _CheckInSheet extends StatefulWidget {
  const _CheckInSheet({required this.kept});

  final bool kept;

  static Future<({String? note, bool shareToFeed})?> show(
    BuildContext context,
    bool kept,
  ) {
    return showModalBottomSheet<({String? note, bool shareToFeed})>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.kept.panel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _CheckInSheet(kept: kept),
    );
  }

  @override
  State<_CheckInSheet> createState() => _CheckInSheetState();
}

class _CheckInSheetState extends State<_CheckInSheet> {
  final _controller = TextEditingController();
  var _shareToFeed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kept = widget.kept;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            kept
                ? LocaleKeys.noteKeptPrompt.tr()
                : LocaleKeys.noteBrokePrompt.tr(),
            style: GoogleFonts.sora(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.kept.paper,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.noteBody.tr(),
            style: GoogleFonts.manrope(
              color: context.kept.mist,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _controller,
            maxLines: 3,
            style: TextStyle(color: context.kept.paper),
            decoration: InputDecoration(
              hintText: kept
                  ? LocaleKeys.noteKeptHint.tr()
                  : LocaleKeys.noteBrokeHint.tr(),
              hintStyle: TextStyle(color: context.kept.mist),
              filled: true,
              fillColor: context.kept.ink,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: context.kept.line),
              ),
            ),
          ),
          const SizedBox(height: 12),
          KeptNativeSwitchTile(
            value: _shareToFeed,
            title: LocaleKeys.shareToFeed.tr(),
            subtitle: LocaleKeys.shareToFeedHelp.tr(),
            onChanged: (v) => setState(() => _shareToFeed = v),
          ),
          const SizedBox(height: 8),
          KeptPrimaryButton(
            label: kept ? LocaleKeys.postKept.tr() : LocaleKeys.postBroke.tr(),
            onPressed: () => Navigator.pop(context, (
              note: _controller.text.trim(),
              shareToFeed: _shareToFeed,
            )),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(LocaleKeys.cancel.tr()),
          ),
        ],
      ),
    );
  }
}

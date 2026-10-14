part of '../room_view.dart';

class _JoinRequestsSheet extends StatelessWidget {
  const _JoinRequestsSheet({
    required this.page,
    required this.onReject,
    required this.onApprove,
  });

  final JoinRequestPage page;
  final Future<void> Function(int requestId) onReject;
  final Future<void> Function(int requestId) onApprove;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocaleKeys.joinRequests.tr(),
              style: GoogleFonts.sora(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.kept.paper,
              ),
            ),
            const SizedBox(height: 12),
            if (page.items.isEmpty)
              Text(
                LocaleKeys.noPendingRequests.tr(),
                style: GoogleFonts.manrope(color: context.kept.mist),
              )
            else
              ...page.items.map(
                (req) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    req.displayName,
                    style: GoogleFonts.manrope(
                      color: context.kept.paper,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    LocaleKeys.wantsToJoin.tr(),
                    style: GoogleFonts.manrope(color: context.kept.mist),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => onReject(req.id!),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: KeptTheme.broke,
                        ),
                      ),
                      IconButton(
                        onPressed: () => onApprove(req.id!),
                        icon: const Icon(
                          Icons.check_rounded,
                          color: KeptTheme.kept,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

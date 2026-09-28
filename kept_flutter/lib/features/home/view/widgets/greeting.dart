part of '../home_view.dart';

class _HomeGreeting extends StatelessWidget {
  const _HomeGreeting({required this.name, required this.signedIn});

  final String? name;
  final bool signedIn;

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final l10n = context.l10n;
    final hello = hour < 12
        ? l10n.greetingMorning
        : hour < 18
        ? l10n.greetingAfternoon
        : l10n.greetingEvening;
    final who = (name != null && name!.trim().isNotEmpty)
        ? name!.trim().split(' ').first
        : signedIn
        ? l10n.greetingFallbackName
        : null;
    final title = who == null ? l10n.appTitle : l10n.greetingNamed(hello, who);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 10, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.sora(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    color: context.kept.paper,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  who == null ? l10n.tagline : l10n.greetingSignedIn,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: context.kept.mist,
                  ),
                ),
              ],
            ),
          ),
          KeptNativeIconButton(
            symbol: 'bell',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.notificationsSoon)),
              );
            },
            size: 40,
            style: CNButtonStyle.glass,
            tint: context.kept.paper,
            materialIcon: Icons.notifications_none_rounded,
            tooltip: context.l10n.notifications,
          ),
        ],
      ),
    );
  }
}

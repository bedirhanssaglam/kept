part of '../home_view.dart';

class _HomeGreeting extends StatelessWidget {
  const _HomeGreeting({required this.name, required this.signedIn});

  final String? name;
  final bool signedIn;

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final hello = hour < 12
        ? LocaleKeys.greetingMorning.tr()
        : hour < 18
        ? LocaleKeys.greetingAfternoon.tr()
        : LocaleKeys.greetingEvening.tr();
    final who = (name != null && name!.trim().isNotEmpty)
        ? name!.trim().split(' ').first
        : signedIn
        ? LocaleKeys.greetingFallbackName.tr()
        : null;
    final title = who == null ? LocaleKeys.appTitle.tr() : LocaleKeys.greetingNamed.tr(namedArgs: {'hello': (hello).toString(), 'name': (who).toString()});

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
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    color: context.kept.paper,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  who == null ? LocaleKeys.tagline.tr() : LocaleKeys.greetingSignedIn.tr(),
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: context.kept.mist,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

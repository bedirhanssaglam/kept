import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../product/theme/kept_theme.dart';
import '../../../product/init/language/localization.dart';
import '../../../product/components/kept_native.dart';
import '../../../product/components/kept_widgets.dart';
import '../data/onboarding_prefs.dart';
import 'login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _page = PageController();
  int _index = 0;

  List<({IconData icon, String title, String body})> _pages(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return [
      (
        icon: Icons.public_rounded,
        title: l10n.onboardingPublicTitle,
        body: l10n.onboardingPublicBody,
      ),
      (
        icon: Icons.verified_rounded,
        title: l10n.onboardingDailyTitle,
        body: l10n.onboardingDailyBody,
      ),
      (
        icon: Icons.groups_rounded,
        title: l10n.onboardingLiveTitle,
        body: l10n.onboardingLiveBody,
      ),
    ];
  }

  Future<void> _finish() async {
    await setOnboardingDone();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const LoginView(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 380),
      ),
    );
  }

  void _next() {
    if (_index >= _pages(context).length - 1) {
      _finish();
      return;
    }
    _page.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final last = _index == _pages(context).length - 1;

    return Scaffold(
      backgroundColor: context.kept.void_,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.kept.wash, context.kept.void_],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 12, 0),
                  child: keptUsesNativeCupertino
                      ? SizedBox(
                          height: 36,
                          width: 88,
                          child: CNButton(
                            label: context.l10n.skip,
                            onPressed: _finish,
                            tint: context.kept.mist,
                            height: 36,
                            shrinkWrap: true,
                            style: CNButtonStyle.plain,
                          ),
                        )
                      : TextButton(
                          onPressed: _finish,
                          child: Text(
                            context.l10n.skip,
                            style: GoogleFonts.manrope(
                              color: context.kept.mist,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _page,
                  itemCount: _pages(context).length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    final page = _pages(context)[i];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 2),
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: KeptTheme.accent.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: KeptTheme.accent.withValues(alpha: 0.35),
                              ),
                            ),
                            child: Icon(
                              page.icon,
                              size: 42,
                              color: KeptTheme.accent,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Text(
                            'KEPT',
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3.2,
                              color: KeptTheme.accent,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            page.title,
                            style: GoogleFonts.sora(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              height: 1.12,
                              letterSpacing: -0.8,
                              color: context.kept.paper,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.body,
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              height: 1.5,
                              color: context.kept.mist,
                            ),
                          ),
                          const Spacer(flex: 3),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages(context).length, (i) {
                        final active = i == _index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOutCubic,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? KeptTheme.accent
                                : context.kept.line,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 22),
                    KeptPrimaryButton(
                      label: last ? context.l10n.letsGo : context.l10n.next,
                      onPressed: _next,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

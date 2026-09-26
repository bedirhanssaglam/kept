import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_native.dart';
import '../../../core/widgets/kept_widgets.dart';
import '../data/onboarding_prefs.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _page = PageController();
  int _index = 0;

  static const _pages = [
    (
      icon: Icons.public_rounded,
      title: 'Public vows',
      body:
          'Make a promise in the open. Others can join and hold the same line with you.',
    ),
    (
      icon: Icons.verified_rounded,
      title: 'Daily keep or break',
      body:
          'Every day you check in — kept it or broke it. One truth. No streaks theater.',
    ),
    (
      icon: Icons.groups_rounded,
      title: 'Live accountability',
      body:
          'See who showed up today on the member board. Presence beats private guilt.',
    ),
  ];

  Future<void> _finish() async {
    await setOnboardingDone();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const LoginScreen(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 380),
      ),
    );
  }

  void _next() {
    if (_index >= _pages.length - 1) {
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
    final last = _index == _pages.length - 1;

    return Scaffold(
      backgroundColor: KeptTheme.void_,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF152019), KeptTheme.void_],
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
                            label: 'Skip',
                            onPressed: _finish,
                            tint: KeptTheme.mist,
                            height: 36,
                            shrinkWrap: true,
                            style: CNButtonStyle.plain,
                          ),
                        )
                      : TextButton(
                          onPressed: _finish,
                          child: Text(
                            'Skip',
                            style: GoogleFonts.manrope(
                              color: KeptTheme.mist,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _page,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    final page = _pages[i];
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
                              color: KeptTheme.paper,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.body,
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              height: 1.5,
                              color: KeptTheme.mist,
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
                      children: List.generate(_pages.length, (i) {
                        final active = i == _index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOutCubic,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active ? KeptTheme.accent : KeptTheme.line,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 22),
                    KeptPrimaryButton(
                      label: last ? 'Let’s go' : 'Next',
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

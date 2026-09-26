import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../core/layout/kept_breakpoints.dart';
import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_widgets.dart';
import '../../../data/vow_repository.dart';
import '../../auth/presentation/sign_in_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.onOpenRoom});

  final ValueChanged<int> onOpenRoom;

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _repo = VowRepository();
  Future<KeptProfile?>? _future;
  bool _signedIn = false;

  @override
  void initState() {
    super.initState();
    _signedIn = client.auth.isAuthenticated;
    client.auth.authInfoListenable.addListener(_onAuth);
    _future = _load();
  }

  void _onAuth() {
    setState(() {
      _signedIn = client.auth.isAuthenticated;
      _future = _load();
    });
  }

  Future<KeptProfile?> _load() async {
    if (!client.auth.isAuthenticated) return null;
    return _repo.getMyProfile();
  }

  Future<void> refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuth);
    super.dispose();
  }

  Future<void> _signIn() async {
    await showSignInSheet(context);
  }

  Future<void> _signOut() async {
    await client.auth.signOutDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF152019), KeptTheme.void_],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: !_signedIn
            ? _SignedOutBody(onSignIn: _signIn)
            : FutureBuilder<KeptProfile?>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(color: KeptTheme.accent),
                    );
                  }
                  if (snapshot.hasError) {
                    return ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        Text(
                          'Could not load profile.\n${snapshot.error}',
                          style: const TextStyle(color: KeptTheme.broke),
                        ),
                        const SizedBox(height: 16),
                        KeptPrimaryButton(label: 'Retry', onPressed: refresh),
                      ],
                    );
                  }
                  final profile = snapshot.data;
                  if (profile == null) {
                    return _SignedOutBody(onSignIn: _signIn);
                  }
                  return RefreshIndicator(
                    color: KeptTheme.accent,
                    backgroundColor: KeptTheme.panel,
                    onRefresh: refresh,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final sidePad =
                            constraints.maxWidth > KeptBreakpoints.contentMax
                            ? (constraints.maxWidth -
                                      KeptBreakpoints.contentMax) /
                                  2
                            : 0.0;
                        return ListView(
                          padding: EdgeInsets.fromLTRB(
                            20 + sidePad,
                            18,
                            20 + sidePad,
                            110,
                          ),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Profile',
                                    style: GoogleFonts.sora(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: KeptTheme.paper,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _signOut,
                                  child: Text(
                                    'Sign out',
                                    style: GoogleFonts.manrope(
                                      color: KeptTheme.mist,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            _IdentityCard(profile: profile),
                            const SizedBox(height: 16),
                            _TodayStats(profile: profile),
                            const SizedBox(height: 28),
                            Text(
                              'Your rooms',
                              style: GoogleFonts.sora(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: KeptTheme.paper,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              profile.rooms.isEmpty
                                  ? 'Join or create a vow to see it here.'
                                  : 'Tap a room to check in or chat.',
                              style: GoogleFonts.manrope(
                                color: KeptTheme.mist,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 14),
                            if (profile.rooms.isEmpty)
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: KeptTheme.panel,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: KeptTheme.line),
                                ),
                                child: Text(
                                  'No memberships yet.',
                                  style: GoogleFonts.manrope(
                                    color: KeptTheme.mist,
                                  ),
                                ),
                              )
                            else
                              ...profile.rooms.map(
                                (room) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: _ProfileRoomTile(
                                    room: room,
                                    onTap: () => widget.onOpenRoom(room.id!),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _SignedOutBody extends StatelessWidget {
  const _SignedOutBody({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.sora(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: KeptTheme.paper,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.shield_moon_rounded,
            size: 56,
            color: KeptTheme.accent,
          ),
          const SizedBox(height: 18),
          Text(
            'Own your word',
            style: GoogleFonts.sora(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: KeptTheme.paper,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Sign in to track keeps, manage rooms, and show up on the board.',
            style: GoogleFonts.manrope(
              color: KeptTheme.mist,
              height: 1.45,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 28),
          KeptPrimaryButton(label: 'Sign in', onPressed: onSignIn),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.profile});

  final KeptProfile profile;

  @override
  Widget build(BuildContext context) {
    final initial = profile.displayName.isNotEmpty
        ? profile.displayName.substring(0, 1).toUpperCase()
        : '?';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            KeptTheme.accent.withValues(alpha: 0.16),
            KeptTheme.panel,
          ],
        ),
        border: Border.all(color: KeptTheme.line),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: KeptTheme.ink,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: KeptTheme.accent.withValues(alpha: 0.45),
              ),
            ),
            child: Text(
              initial,
              style: GoogleFonts.sora(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: KeptTheme.accent,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: KeptTheme.paper,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${profile.memberRoomCount} active vow'
                  '${profile.memberRoomCount == 1 ? '' : 's'}',
                  style: GoogleFonts.manrope(
                    color: KeptTheme.mist,
                    fontSize: 13,
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

class _TodayStats extends StatelessWidget {
  const _TodayStats({required this.profile});

  final KeptProfile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            label: 'Kept',
            value: '${profile.keptToday}',
            color: KeptTheme.kept,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            label: 'Broke',
            value: '${profile.brokeToday}',
            color: KeptTheme.broke,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            label: 'Open',
            value: '${profile.pendingToday}',
            color: KeptTheme.pending,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: KeptTheme.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: KeptTheme.line),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.sora(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: KeptTheme.mist,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileRoomTile extends StatelessWidget {
  const _ProfileRoomTile({required this.room, required this.onTap});

  final VowRoom room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cat = CategoryStyle.of(room.category);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: KeptTheme.panel,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: KeptTheme.line),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KeptChip(label: cat.label, color: cat.color),
                    const SizedBox(height: 10),
                    Text(
                      room.title,
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: KeptTheme.paper,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: KeptTheme.mist),
            ],
          ),
        ),
      ),
    );
  }
}

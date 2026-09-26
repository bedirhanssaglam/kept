import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';

import '../../../core/layout/kept_breakpoints.dart';
import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_widgets.dart';
import '../../../data/vow_repository.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({
    super.key,
    required this.onOpenRoom,
    this.bottomPadding = 24,
  });

  final ValueChanged<int> onOpenRoom;
  final double bottomPadding;

  @override
  State<DiscoverScreen> createState() => DiscoverScreenState();
}

class DiscoverScreenState extends State<DiscoverScreen> {
  final _repo = VowRepository();
  late Future<VowRoomPage> _future;

  @override
  void initState() {
    super.initState();
    _future = _repo.listPublicRooms(limit: 40, offset: 0);
  }

  Future<void> refresh() async {
    setState(() => _future = _repo.listPublicRooms(limit: 40, offset: 0));
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: KeptTheme.void_,
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= KeptBreakpoints.compact;
            final maxW = constraints.maxWidth >= KeptBreakpoints.expanded
                ? KeptBreakpoints.contentWide
                : KeptBreakpoints.contentMax;
            final sidePad = constraints.maxWidth > maxW
                ? (constraints.maxWidth - maxW) / 2
                : 0.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    22 + sidePad,
                    16,
                    22 + sidePad,
                    8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover',
                        style: GoogleFonts.sora(
                          fontSize: wide ? 32 : 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          color: KeptTheme.paper,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Public vows you can join and keep together.',
                        style: GoogleFonts.manrope(
                          color: KeptTheme.mist,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: KeptTheme.accent,
                    backgroundColor: KeptTheme.panel,
                    onRefresh: refresh,
                    child: FutureBuilder<VowRoomPage>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: KeptTheme.accent,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return ListView(
                            padding: EdgeInsets.fromLTRB(
                              24 + sidePad,
                              24,
                              24 + sidePad,
                              24,
                            ),
                            children: [
                              Text(
                                'Could not load vows.\n${snapshot.error}',
                                style: const TextStyle(color: KeptTheme.broke),
                              ),
                            ],
                          );
                        }
                        final rooms = snapshot.data?.items ?? [];
                        if (rooms.isEmpty) {
                          return ListView(
                            padding: EdgeInsets.fromLTRB(
                              22 + sidePad,
                              40,
                              22 + sidePad,
                              40,
                            ),
                            children: [
                              Text(
                                'No public vows yet. Create one from Home.',
                                style: GoogleFonts.manrope(
                                  color: KeptTheme.mist,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          );
                        }

                        if (wide) {
                          return GridView.builder(
                            padding: EdgeInsets.fromLTRB(
                              16 + sidePad,
                              12,
                              16 + sidePad,
                              widget.bottomPadding,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      constraints.maxWidth >=
                                          KeptBreakpoints.expanded
                                      ? 380
                                      : 420,
                                  mainAxisSpacing: 14,
                                  crossAxisSpacing: 14,
                                  childAspectRatio: 1.15,
                                ),
                            itemCount: rooms.length,
                            itemBuilder: (context, index) {
                              final room = rooms[index];
                              return _VowCard(
                                room: room,
                                onTap: () => widget.onOpenRoom(room.id!),
                              );
                            },
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            16 + sidePad,
                            12,
                            16 + sidePad,
                            widget.bottomPadding,
                          ),
                          itemCount: rooms.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final room = rooms[index];
                            return _VowCard(
                              room: room,
                              onTap: () => widget.onOpenRoom(room.id!),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _VowCard extends StatelessWidget {
  const _VowCard({required this.room, required this.onTap});

  final VowRoom room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cat = CategoryStyle.of(room.category);
    final policy = switch (room.joinPolicy) {
      'approval' => 'Approval',
      'invite' => 'Invite',
      'closed' => 'Closed',
      _ => 'Open',
    };
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: KeptTheme.panel.withValues(alpha: 0.92),
            border: Border.all(color: KeptTheme.line),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    KeptChip(label: cat.label, color: cat.color),
                    const SizedBox(width: 8),
                    KeptChip(label: policy, color: KeptTheme.pending),
                    const Spacer(),
                    Text(
                      '${room.memberCount} members',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: KeptTheme.mist,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  room.title,
                  style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: KeptTheme.paper,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  room.rule,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    height: 1.4,
                    color: KeptTheme.mist,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      'Enter room',
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: KeptTheme.accent,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: KeptTheme.accent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';

import '../../../product/utility/layout/kept_breakpoints.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/components/async_data_widget.dart';
import '../../../product/components/vow_room_card.dart';
import '../view_model/discover_view_model.dart';
import '../../../product/init/language/localization.dart';

class DiscoverView extends ConsumerStatefulWidget {
  const DiscoverView({
    super.key,
    required this.onOpenRoom,
    this.bottomPadding = 24,
  });

  final ValueChanged<int> onOpenRoom;
  final double bottomPadding;

  @override
  ConsumerState<DiscoverView> createState() => DiscoverViewState();
}

class DiscoverViewState extends ConsumerState<DiscoverView> {
  Future<void> refresh() {
    return ref.read(discoverViewModelProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.kept.void_,
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
                        context.l10n.navDiscover,
                        style: GoogleFonts.sora(
                          fontSize: wide ? 32 : 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          color: context.kept.paper,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.discoverSubtitle,
                        style: GoogleFonts.manrope(
                          color: context.kept.mist,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: KeptTheme.accent,
                    backgroundColor: context.kept.panel,
                    onRefresh: refresh,
                    child: AsyncDataWidget<VowRoomPage>(
                      asyncValue: ref
                          .watch(discoverViewModelProvider)
                          .valueOrNull
                          ?.rooms,
                      loadingWidget: const Center(
                        child: CircularProgressIndicator(
                          color: KeptTheme.accent,
                        ),
                      ),
                      onError: (error) => ListView(
                        padding: EdgeInsets.fromLTRB(
                          24 + sidePad,
                          24,
                          24 + sidePad,
                          24,
                        ),
                        children: [
                          Text(
                            context.l10n.couldNotLoadVows('$error'),
                            style: TextStyle(color: KeptTheme.broke),
                          ),
                        ],
                      ),
                      onData: (page) {
                        final rooms = page?.items ?? [];
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
                                context.l10n.noPublicVows,
                                style: GoogleFonts.manrope(
                                  color: context.kept.mist,
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
                                  childAspectRatio: 1.02,
                                ),
                            itemCount: rooms.length,
                            itemBuilder: (context, index) {
                              final room = rooms[index];
                              return VowRoomCard.room(
                                room,
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
                            return VowRoomCard.room(
                              room,
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

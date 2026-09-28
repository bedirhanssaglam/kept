import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';

import '../../../product/theme/kept_theme.dart';
import '../../../product/init/dependency/dependency_items.dart';
import '../../../product/service/vow_repository.dart';
import '../../../features/vows/domain/vow_labels.dart';
import '../../../product/init/language/localization.dart';

class MembersView extends ConsumerStatefulWidget {
  const MembersView({super.key, required this.roomId, required this.title});

  final int roomId;
  final String title;

  @override
  ConsumerState<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends ConsumerState<MembersView> {
  VowRepository get _repo => ref.read(vowRepositoryProvider);
  final _scroll = ScrollController();
  final List<MemberDayStatus> _items = [];
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _reload();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_hasMore || _loadingMore) return;
    if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 240) {
      _loadMore();
    }
  }

  Future<void> _reload() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await _repo.listMembers(widget.roomId, limit: 30, offset: 0);
      if (!mounted) return;
      setState(() {
        _items
          ..clear()
          ..addAll(page.items);
        _hasMore = page.hasMore;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _loading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore) return;
    setState(() => _loadingMore = true);
    try {
      final page = await _repo.listMembers(
        widget.roomId,
        limit: 30,
        offset: _items.length,
      );
      if (!mounted) return;
      setState(() {
        _items.addAll(page.items);
        _hasMore = page.hasMore;
        _loadingMore = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kept.void_,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          context.l10n.membersTitle(widget.title),
          style: GoogleFonts.sora(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: KeptTheme.accent),
            )
          : _error != null
          ? Center(
              child: Text(
                _error!,
                style: TextStyle(color: KeptTheme.broke),
              ),
            )
          : RefreshIndicator(
              color: KeptTheme.accent,
              onRefresh: _reload,
              child: ListView.separated(
                controller: _scroll,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                itemCount: _items.length + (_loadingMore ? 1 : 0),
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index >= _items.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: KeptTheme.accent,
                        ),
                      ),
                    );
                  }
                  final m = _items[index];
                  final tone = m.kept == null
                      ? KeptTheme.pending
                      : m.kept!
                      ? KeptTheme.kept
                      : KeptTheme.broke;
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: context.kept.panel,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.kept.line),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: tone.withValues(alpha: 0.2),
                          child: Text(
                            m.displayName.isNotEmpty
                                ? m.displayName[0].toUpperCase()
                                : '?',
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w700,
                              color: tone,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.displayName,
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w700,
                                  color: context.kept.paper,
                                ),
                              ),
                              Text(
                                vowRoleLabel(context.l10n, m.role),
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  color: context.kept.mist,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          vowDayStatus(context.l10n, m.kept),
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: tone,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}

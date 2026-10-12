import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/components/kept_native.dart';
import '../../../product/service/vow_repository.dart';
import '../../auth/view/sign_in_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

class FeedCommentsSheet {
  const FeedCommentsSheet({
    required this.targetType,
    required this.targetId,
  });

  final String targetType;
  final int targetId;

  Future<int?> show(BuildContext context) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.kept.panel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _FeedCommentsSheet(
          targetType: targetType,
          targetId: targetId,
        );
      },
    );
  }
}

class _FeedCommentsSheet extends ConsumerStatefulWidget {
  const _FeedCommentsSheet({
    required this.targetType,
    required this.targetId,
  });

  final String targetType;
  final int targetId;

  @override
  ConsumerState<_FeedCommentsSheet> createState() => _FeedCommentsSheetState();
}

class _FeedCommentsSheetState extends ConsumerState<_FeedCommentsSheet> {
  VowRepository get _repo => ref.read(VowRepository.provider);
  final _controller = TextEditingController();
  final List<FeedComment> _comments = [];
  bool _loading = true;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await _repo.listComments(
        targetType: widget.targetType,
        targetId: widget.targetId,
        limit: 40,
        offset: 0,
      );
      if (!mounted) return;
      setState(() {
        _comments
          ..clear()
          ..addAll(page.items);
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;

    if (!client.auth.isAuthenticated) {
      final ok = await const SignInSheet().show(context);
      if (!ok || !mounted) return;
    }

    setState(() => _sending = true);
    try {
      final created = await _repo.addComment(
        targetType: widget.targetType,
        targetId: widget.targetId,
        body: text,
      );
      if (!mounted) return;
      _controller.clear();
      setState(() => _comments.add(created));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.72,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.kept.line,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.comments.tr(),
                      style: GoogleFonts.sora(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context, _comments.length),
                    icon: Icon(
                      Icons.close_rounded,
                      color: context.kept.mist,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: KeptTheme.accent),
                    )
                  : _error != null
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        _error!,
                        style: TextStyle(color: KeptTheme.broke),
                      ),
                    )
                  : _comments.isEmpty
                  ? Center(
                      child: Text(
                        LocaleKeys.noComments.tr(),
                        style: GoogleFonts.manrope(color: context.kept.mist),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: _comments.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final c = _comments[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: KeptTheme.accent.withValues(alpha: 0.14),
                                border: Border.all(
                                  color: KeptTheme.accent.withValues(
                                    alpha: 0.35,
                                  ),
                                ),
                              ),
                              child: Text(
                                c.displayName.isNotEmpty
                                    ? c.displayName
                                          .substring(0, 1)
                                          .toUpperCase()
                                    : '?',
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.w700,
                                  color: KeptTheme.accent,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${c.displayName} ',
                                          style: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w700,
                                            color: context.kept.paper,
                                          ),
                                        ),
                                        TextSpan(
                                          text: c.body,
                                          style: GoogleFonts.manrope(
                                            color: context.kept.paper
                                                .withValues(
                                                  alpha: 0.9,
                                                ),
                                            height: 1.35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _ago(c.createdAt.toLocal()),
                                    style: GoogleFonts.manrope(
                                      fontSize: 11,
                                      color: context.kept.mist,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: context.kept.line)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: context.kept.paper),
                      decoration: InputDecoration(
                        hintText: LocaleKeys.addComment.tr(),
                        hintStyle: TextStyle(color: context.kept.mist),
                        filled: true,
                        fillColor: context.kept.ink,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: context.kept.line),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: context.kept.line),
                        ),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  KeptNativeIconButton(
                    symbol: 'paperplane.fill',
                    onPressed: _sending ? null : _send,
                    size: 44,
                    style: CNButtonStyle.filled,
                    tint: KeptTheme.accent,
                    materialIcon: Icons.send_rounded,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _ago(DateTime t) {
  final diff = DateTime.now().difference(t);
  if (diff.inMinutes < 1) return 'now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m';
  if (diff.inHours < 24) return '${diff.inHours}h';
  return '${diff.inDays}d';
}

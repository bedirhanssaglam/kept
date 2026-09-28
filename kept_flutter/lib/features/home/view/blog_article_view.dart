import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';

import '../../../product/components/async_data_widget.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/components/kept_widgets.dart';
import '../view_model/blog_article_view_model.dart';

class BlogArticleView extends ConsumerStatefulWidget {
  const BlogArticleView({super.key, required this.slug});

  final String slug;

  @override
  ConsumerState<BlogArticleView> createState() => _BlogArticleViewState();
}

class _BlogArticleViewState extends ConsumerState<BlogArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kept.void_,
      body: AsyncDataWidget<BlogPost>(
        asyncValue: ref.watch(blogArticleProvider(widget.slug)),
        onError: (error) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Could not load article.\n$error',
              style: TextStyle(color: KeptTheme.broke),
            ),
          ),
        ),
        onData: (post) {
          if (post == null) {
            return const SizedBox.shrink();
          }
          final cat = CategoryStyle.of(
            context,
            switch (post.topic) {
              'water' => 'health',
              'move' => 'move',
              'focus' => 'focus',
              _ => 'custom',
            },
          );

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: context.kept.void_,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_rounded),
                  color: context.kept.paper,
                ),
                title: Text(
                  'Kept Journal',
                  style: GoogleFonts.sora(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KeptChip(
                        label: post.topic.toUpperCase(),
                        color: cat.color,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        post.title,
                        style: GoogleFonts.sora(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          height: 1.12,
                          color: context.kept.paper,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        post.excerpt,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          height: 1.45,
                          color: context.kept.mist,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        height: 1,
                        color: context.kept.line,
                      ),
                      const SizedBox(height: 28),
                      Text(
                        post.body,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          height: 1.65,
                          color: context.kept.paper.withValues(alpha: 0.92),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

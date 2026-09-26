import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';

import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_widgets.dart';
import '../../../data/vow_repository.dart';

class BlogArticleScreen extends StatefulWidget {
  const BlogArticleScreen({super.key, required this.slug});

  final String slug;

  @override
  State<BlogArticleScreen> createState() => _BlogArticleScreenState();
}

class _BlogArticleScreenState extends State<BlogArticleScreen> {
  final _repo = VowRepository();
  late final Future<BlogPost> _future = _repo.getBlogPost(widget.slug);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KeptTheme.void_,
      body: FutureBuilder<BlogPost>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(color: KeptTheme.accent),
            );
          }
          if (snapshot.hasError || snapshot.data == null) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Could not load article.\n${snapshot.error}',
                  style: const TextStyle(color: KeptTheme.broke),
                ),
              ),
            );
          }
          final post = snapshot.data!;
          final cat = CategoryStyle.of(
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
                backgroundColor: KeptTheme.void_,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: KeptTheme.paper,
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
                          color: KeptTheme.paper,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        post.excerpt,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          height: 1.45,
                          color: KeptTheme.mist,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        height: 1,
                        color: KeptTheme.line,
                      ),
                      const SizedBox(height: 28),
                      Text(
                        post.body,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          height: 1.65,
                          color: KeptTheme.paper.withValues(alpha: 0.92),
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

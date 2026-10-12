import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';

import '../../../product/service/vow_repository.dart';

abstract final class BlogArticleViewModel {
  static final provider = FutureProvider.autoDispose.family<BlogPost, String>((
    ref,
    slug,
  ) {
    return ref.watch(VowRepository.provider).getBlogPost(slug);
  });
}

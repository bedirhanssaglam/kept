import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';

import '../../../product/init/dependency/dependency_items.dart';

final blogArticleProvider = FutureProvider.autoDispose.family<BlogPost, String>(
  (ref, slug) {
    return ref.watch(vowRepositoryProvider).getBlogPost(slug);
  },
);

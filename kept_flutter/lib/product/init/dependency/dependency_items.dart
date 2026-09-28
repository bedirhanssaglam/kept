import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/vow_repository.dart';

/// Shared Serverpod client wrapper. Views read this instead of constructing
/// a repository on every screen.
final vowRepositoryProvider = Provider<VowRepository>(
  (ref) => VowRepository(),
);

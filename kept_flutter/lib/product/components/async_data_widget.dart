import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/kept_theme.dart';

final class AsyncDataWidget<T> extends StatelessWidget {
  const AsyncDataWidget({
    required this.asyncValue,
    required this.onData,
    super.key,
    this.onError,
    this.loadingWidget,
  });

  final AsyncValue<T?>? asyncValue;
  final Widget Function(T? data) onData;
  final Widget Function(Object error)? onError;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    final value = asyncValue;
    if (value == null || value.isLoading) {
      return loadingWidget ??
          const Center(
            child: CircularProgressIndicator(color: KeptTheme.accent),
          );
    }
    if (value.hasError) {
      return onError?.call(value.error!) ??
          Center(child: Text('${value.error}'));
    }
    return onData(value.value);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseViewModel<S> extends AutoDisposeAsyncNotifier<S> {
  S buildInitialState();

  Future<void> updateAsyncValue<T>({
    required Future<T> Function() request,
    required S Function(S state, AsyncValue<T> newValue) onValue,
  }) async {
    final current = state.valueOrNull ?? buildInitialState();
    state = AsyncData(onValue(current, const AsyncLoading()));
    final result = await AsyncValue.guard(request);
    state = AsyncData(onValue(current, result));
  }
}

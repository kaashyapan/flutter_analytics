/// @nodoc
library lifecycle;

import 'dart:ui' show AppLifecycleState;
export 'dart:ui' show AppLifecycleState;

/// @nodoc
class AppLifecycle {
  /// @nodoc
  factory AppLifecycle() => _appLifecycle;

  AppLifecycle._internal()
      : _subscriptions = [],
        _state = AppLifecycleState.resumed;

  static final _appLifecycle = AppLifecycle._internal();

  final List<void Function(AppLifecycleState state)> _subscriptions;
  AppLifecycleState _state;

  /// @nodoc
  AppLifecycleState get state => _state;
  set state(AppLifecycleState newState) {
    if (newState == null || newState == _state) {
      return;
    }

    _state = newState;

    for (final subscription in _subscriptions) {
      subscription(newState);
    }
  }

  /// @nodoc
  void subscribe(void Function(AppLifecycleState state) onAppLifecycleState) =>
      _subscriptions.add(onAppLifecycleState);
}

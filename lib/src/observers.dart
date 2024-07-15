import 'dart:developer' as dev;

import 'package:flutter/material.dart';

/// An interface for observing the behavior of a [Navigator].
class FluNavObserver extends NavigatorObserver {
  /// [FluNavObserver] constructor
  FluNavObserver({
    this.onNavigationChanged,
    this.log = false,
  });

  /// Either to show logs or not
  final bool log;

  /// Navigation callback
  final void Function(
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
    NavigationTypes type,
  )? onNavigationChanged;

  /// Log routing changes
  void _log(String message) {
    if (log) {
      dev.log(message);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(
      // ignore: lines_longer_than_80_chars
      'CLOSE TO ROUTE ${previousRoute?.settings.name} with args: ${previousRoute?.settings.arguments}',
    );
    super.didPop(route, previousRoute);
    onNavigationChanged?.call(route, previousRoute, NavigationTypes.pop);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(
      // ignore: lines_longer_than_80_chars
      'GOING TO ROUTE ${route.settings.name} with args: ${route.settings.arguments}',
    );
    super.didPush(route, previousRoute);
    onNavigationChanged?.call(route, previousRoute, NavigationTypes.push);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log(
      // ignore: lines_longer_than_80_chars
      'GOING TO ROUTE ${newRoute?.settings.name} with args: ${newRoute?.settings.arguments}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    onNavigationChanged?.call(newRoute, oldRoute, NavigationTypes.replace);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('REMOVING ROUTE ${route.settings.name}');
    super.didRemove(route, previousRoute);
    onNavigationChanged?.call(route, previousRoute, NavigationTypes.remove);
  }
}

/// Navigation types
enum NavigationTypes {
  // ignore: public_member_api_docs
  push,
  // ignore: public_member_api_docs
  replace,
  // ignore: public_member_api_docs
  pop,
  // ignore: public_member_api_docs
  remove,
}

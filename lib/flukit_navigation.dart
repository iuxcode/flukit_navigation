library flukit_navigation;

import 'package:flukit_core/flukit_core.dart';
import 'package:flukit_navigation/src/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

export 'package:go_router/go_router.dart';

export './src/observers.dart';
export './src/page.dart';
export './src/transitions.dart';

/// Provide navigation utilities such as [GoRouter] and [NavigatorObserver]
extension FlukitRouter on Flukit {
  /// Build routes based on the provided list of pages
  /// and return a [RouterConfig] instance.
  RouterConfig<Object> buildRouterConfig(
    List<FluPage> pages, {
    List<NavigatorObserver>? observers,
  }) {
    // assert only one page is initial
    assert(
      pages.where((page) => page.isInitial).length == 1,
      'A page must be initial. Only one page can be initial.',
    );

    return GoRouter(
      observers: observers,
      routes: pages
          .map(
            (page) => GoRoute(
              name: page.name,
              path: page.isInitial
                  ? '/'
                  : (page.name.startsWith('/') ? page.name : '/${page.name}'),
              pageBuilder: (context, state) {
                return page.buildRouteAnimation(
                  state,
                  page.content(context, state),
                );
              },
            ),
          )
          .toList(),
    );
  }
}

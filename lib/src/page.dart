import 'package:flukit_navigation/flukit_navigation.dart';
import 'package:flutter/material.dart';

/// A class that represents a page in the app
/// and its associated [PageTransitions]
class FluPage {
  /// Builds a [FluPage] with the provided [name] and [content]
  FluPage({
    required this.name,
    required this.content,
    this.isInitial = false,
    this.transition = PageTransitions.rightToLeft,
    this.transitionDuration = const Duration(milliseconds: 300),
  });

  /// The [Widget] content of the page
  final Widget Function(BuildContext, GoRouterState) content;

  /// The name of the page
  /// The path of the page will be `/` + [name]
  final String name;

  /// The [PageTransitions] type of the page
  /// Defaults to [PageTransitions.rightToLeft]
  /// See [PageTransitions] for more information
  final PageTransitions transition;

  /// Either true if the page is the initial page
  final bool isInitial;

  /// Animation duration
  final Duration transitionDuration;

  /// Generates a custom transition page for the given state and content widget.
  /// Returns a [CustomTransitionPage].
  CustomTransitionPage<dynamic> buildRouteAnimation(
    GoRouterState state,
    Widget content,
  ) =>
      CustomTransitionPage<dynamic>(
        key: state.pageKey,
        child: content,
        transitionDuration: transitionDuration,
        transitionsBuilder:
            navigationService.buildPageTransitions(transition, content),
      );
}

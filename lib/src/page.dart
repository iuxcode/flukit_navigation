import 'package:flukit_navigation/flukit_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FluPage {
  final String name;
  final PageTransitions transition;
  final Widget content;

  FluPage({
    required this.name,
    required this.content,
    this.transition = PageTransitions.rightToLeft,
  });

  CustomTransitionPage<dynamic> buildRouteAnimation(
    GoRouterState state,
    Widget content,
  ) =>
      CustomTransitionPage<dynamic>(
        key: state.pageKey,
        child: content,
        transitionsBuilder:
            navigationService.buildPageTransitions(transition, content),
      );
}

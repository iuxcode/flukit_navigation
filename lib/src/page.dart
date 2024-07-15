import 'package:flukit_navigation/flukit_navigation.dart';
import 'package:flukit_navigation/src/transitions_builders/defaults.dart';
import 'package:flutter/cupertino.dart';
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
    this.reverseTransitionDuration,
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

  /// Animation transition duration
  final Duration transitionDuration;

  /// Animation reverse transition duration
  final Duration? reverseTransitionDuration;

  /// Generates the appropriate page transition based
  /// on the given [PageTransitions] type.
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
      _buildPageTransitions(PageTransitions transition, Widget page) {
    switch (transition) {
      case PageTransitions.leftToRight:
        return (context, animation, secondaryAnimation, child) =>
            SlideLeftTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.downToUp:
        return (context, animation, secondaryAnimation, child) =>
            SlideDownTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.upToDown:
        return (context, animation, secondaryAnimation, child) =>
            SlideTopTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.noTransition:
        return (context, animation, secondaryAnimation, child) => child;

      case PageTransitions.rightToLeft:
        return (context, animation, secondaryAnimation, child) =>
            SlideRightTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.zoom:
        return (context, animation, secondaryAnimation, child) =>
            ZoomInTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.fadeIn:
        return (context, animation, secondaryAnimation, child) =>
            FadeInTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.rightToLeftWithFade:
        return (context, animation, secondaryAnimation, child) =>
            RightToLeftFadeTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.leftToRightWithFade:
        return (context, animation, secondaryAnimation, child) =>
            LeftToRightFadeTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.cupertino:
        return (context, animation, secondaryAnimation, child) =>
            CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: true,
              child: child,
            );

      case PageTransitions.size:
        return (context, animation, secondaryAnimation, child) =>
            SizeTransitions().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case PageTransitions.fade:
        return (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );

      case PageTransitions.circularReveal:
        return (context, animation, secondaryAnimation, child) =>
            CircularRevealTransition().buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            );
    }
  }

  /// Generates a custom transition page for the given state and content widget.
  /// Returns a [CustomTransitionPage].
  CustomTransitionPage<dynamic> buildRouteAnimation(
    GoRouterState state,
    Widget content,
  ) =>
      CustomTransitionPage<dynamic>(
        key: state.pageKey,
        name: state.name,
        child: content,
        transitionDuration: transitionDuration,
        reverseTransitionDuration:
            reverseTransitionDuration ?? transitionDuration,
        transitionsBuilder: _buildPageTransitions(transition, content),
      );
}

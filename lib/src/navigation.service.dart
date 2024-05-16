import 'package:flukit_core/flukit_core.dart';
import 'package:flukit_navigation/src/observers.dart';
import 'package:flukit_navigation/src/page.dart';
import 'package:flukit_navigation/src/transitions.dart';
import 'package:flukit_navigation/src/transitions_builders/defaults.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Provide navigation utilities such as [GoRouter] and [FluNavObserver]
class NavigationService {
  /// Navigation service constructor
  NavigationService(this.fluInstance);

  /// [Flukit] instance
  final Flukit fluInstance;

  /// Build routes based on the provided list of pages
  /// and return a GoRouter instance.
  GoRouter buildRoutes(List<FluPage> pages) => GoRouter(
        routes: pages
            .map(
              (page) => GoRoute(
                name: page.name,
                path: page.isInitial
                    ? '/'
                    : (page.name.startsWith('/') ? page.name : '/${page.name}'),
                pageBuilder: (context, state) {
                  return page.buildRouteAnimation(state, page.content);
                },
              ),
            )
            .toList(),
      );

  /// Generates the appropriate page transition based
  /// on the given [PageTransitions] type.
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
      buildPageTransitions(PageTransitions transition, Widget page) {
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
}

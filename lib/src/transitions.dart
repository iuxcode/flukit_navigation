import 'package:flukit_navigation/src/transitions_builders/defaults.dart';
import 'package:flutter/cupertino.dart';

/// Available page transitions
enum PageTransitions {
  /// Fade transition
  fade,

  /// Fade in transition
  fadeIn,

  /// Right to Left transition
  rightToLeft,

  /// Left to Right transition
  leftToRight,

  /// Up to Down transition
  upToDown,

  /// Down to Up transition
  downToUp,

  /// Right to Left with fade transition
  rightToLeftWithFade,

  /// Left to Right with fade transition
  leftToRightWithFade,

  /// Zoom transition
  zoom,

  /// No transition
  noTransition,

  /// Cupertino transition
  cupertino,

  /// Size transition
  size,

  /// Circular reveal transition
  circularReveal,
}

/// Generates the appropriate page transition based
/// on the given [PageTransitions] type.
Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
    buildFluPageTransitions(PageTransitions transition, Widget page) {
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
      return (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
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

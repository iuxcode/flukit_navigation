import 'dart:math' show max, sqrt;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// providing circular reveal clip for route transition.
class CircularRevealClipper extends CustomClipper<Path> {
  /// providing circular reveal clip for route transition.
  CircularRevealClipper({
    required this.fraction,
    this.centerAlignment,
    this.centerOffset,
    this.minRadius,
    this.maxRadius,
  });

  /// The alignment of the center of the clip.
  final Alignment? centerAlignment;

  /// The offset of the center of the clip.
  final Offset? centerOffset;

  /// The fraction of the animation that the clip will be reveal.
  final double fraction;

  /// The maximum radius of the clip.
  final double? maxRadius;

  /// The minimum radius of the clip.
  final double? minRadius;

  /// Returns a Path that represents an oval shape
  /// centered on the provided Size. If centerAlignment is not null,
  /// the oval is aligned based on the centerAlignment, otherwise,
  /// it is aligned based on centerOffset or the center of the Size.
  /// The minimum radius is determined by minRadius,
  /// defaulting to 0 if not provided, and the maximum radius is determined
  /// by maxRadius or calculated based on the provided size and center.
  /// The function returns a Path representing the oval shape.
  @override
  Path getClip(Size size) {
    final center = centerAlignment?.alongSize(size) ??
        centerOffset ??
        Offset(size.width / 2, size.height / 2);
    final minRadius = this.minRadius ?? 0;
    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(minRadius, maxRadius, fraction)!,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  /// Calculate the maximum radius based on the size
  /// of the shape and its center point.
  static double calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}

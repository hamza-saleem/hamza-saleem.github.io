import 'package:flutter/material.dart';

class Breakpoints {
  Breakpoints._();
  static const double mobile = 600;
  static const double tablet = 1024;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isMobile => screenWidth < Breakpoints.mobile;
  bool get isTablet =>
      screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.tablet;
  bool get isDesktop => screenWidth >= Breakpoints.tablet;

  /// Returns [mobile] below 600px, [tablet] between 600–1024px (falls back to
  /// [desktop] if not provided), and [desktop] above 1024px.
  T responsive<T>({
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? desktop;
    return desktop;
  }

  /// Horizontal section padding — tight on mobile, roomy on desktop.
  double get sectionPaddingH => responsive(
        mobile: 20.0,
        tablet: 48.0,
        desktop: 80.0,
      );

  /// Vertical section padding.
  double get sectionPaddingV => responsive(
        mobile: 56.0,
        tablet: 72.0,
        desktop: 96.0,
      );
}

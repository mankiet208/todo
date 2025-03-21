import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  static const double maxMobileWidth = 600;
  static const double maxTabletWidth = 900;

  bool get isMobile => MediaQuery.of(this).size.width < maxMobileWidth;

  bool get isTablet =>
      MediaQuery.of(this).size.width >= maxMobileWidth &&
      MediaQuery.of(this).size.width < maxTabletWidth;

  bool get isDesktop => MediaQuery.of(this).size.width >= maxTabletWidth;
}

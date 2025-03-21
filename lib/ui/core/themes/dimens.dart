import 'package:flutter/material.dart';

abstract final class Dimensions {
  const Dimensions();

  static const extraSmallPadding = 4.0;
  static const smallPadding = 8.0;
  static const padding = 16.0;

  /// Horizontal padding for screen edges
  double get paddingScreenHorizontal;

  /// Vertical padding for screen edges
  double get paddingScreenVertical;

  double get profilePictureSize;

  /// Horizontal symmetric padding for screen edges
  EdgeInsets get edgeInsetsScreenHorizontal => EdgeInsets.symmetric(
        horizontal: paddingScreenHorizontal,
      );

  /// Symmetric padding for screen edges
  EdgeInsets get edgeInsetsScreenSymmetric => EdgeInsets.symmetric(
        horizontal: paddingScreenHorizontal,
        vertical: paddingScreenVertical,
      );

  static final Dimensions desktop = _DimensionsDesktop();
  static final Dimensions mobile = _DimensionsMobile();

  /// Get dimensions definition based on screen size
  factory Dimensions.of(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).width) {
        > 600 => desktop,
        _ => mobile,
      };
}

/// Mobile dimensions
final class _DimensionsMobile extends Dimensions {
  @override
  final double paddingScreenHorizontal = 24.0;

  @override
  final double paddingScreenVertical = Dimensions.padding;

  @override
  final double profilePictureSize = 64.0;
}

/// Desktop/Web dimensions
final class _DimensionsDesktop extends Dimensions {
  @override
  final double paddingScreenHorizontal = 100.0;

  @override
  final double paddingScreenVertical = 64.0;

  @override
  final double profilePictureSize = 128.0;
}

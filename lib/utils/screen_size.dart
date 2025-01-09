import 'dart:ui';

class ScreenSize {
  static double get _devicePixelRatio =>
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  // Screen size in real pixels
  static double get screenWidthPixels =>
      PlatformDispatcher.instance.views.first.physicalSize.shortestSide;
  static double get screenHeightPixels =>
      PlatformDispatcher.instance.views.first.physicalSize.longestSide;

  // Screen size in density independent pixels
  static double get screenWidth => (screenWidthPixels / _devicePixelRatio);
  static double get screenHeight => (screenHeightPixels / _devicePixelRatio);
}

enum Routes {
  login,
  register,
  home,
  setting,
}

extension RoutesExtension on Routes {
  String get path {
    if (this == Routes.home) {
      return '/';
    }
    return '/$name';
  }
}

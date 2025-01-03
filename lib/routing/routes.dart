enum Routes {
  home,
  login,
  register,
  setting,
}

extension RoutesExtension on Routes {
  String get path => '/$name';
}

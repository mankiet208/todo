import 'dart:collection';

import 'package:todo/ui/setting/view_model/setting_view_model.dart';

import 'routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/repositories/auth/auth_repository.dart';
import 'package:todo/ui/auth/login/view_model/login_view_model.dart';
import 'package:todo/ui/auth/login/widget/login_screen.dart';
import 'package:todo/ui/home/widget/home_screen.dart';
import 'package:todo/ui/home/view_model/home_view_model.dart';
import 'package:todo/ui/setting/widget/setting_screen.dart';

typedef GoRouterPageBuilder = Widget Function();

class GoRoutereManager {
  GoRoutereManager._internal();

  static final GoRoutereManager _instance = GoRoutereManager._internal();

  static GoRoutereManager get instance => _instance;

  final Map<String, Widget> _pages = HashMap();

  // [ISSUE]
  // The current version of go_router will rebuild parent view
  // whenever we push() to a child view, or pop() to parent
  GoRouter getRouter(AuthRepository authRepository) {
    return GoRouter(
      initialLocation: Routes.home.path,
      debugLogDiagnostics: true,
      redirect: _redirect,
      refreshListenable: authRepository,
      routes: [
        GoRoute(
          name: Routes.login.name,
          path: Routes.login.path,
          builder: (context, state) {
            return LoginScreen(
              viewModel: LoginViewModel(
                authRepository: context.read(),
              ),
            );
          },
        ),
        GoRoute(
          name: Routes.home.name,
          path: Routes.home.path,
          builder: (context, state) {
            return _getStoredPage(
              routes: Routes.home,
              pageBuilder: () {
                return HomeScreen(
                  viewModel: HomeViewModel(
                    authRepository: context.read(),
                    todoRepository: context.read(),
                  ),
                );
              },
            );
          },
          routes: [
            GoRoute(
              name: Routes.setting.name,
              path: Routes.setting.name,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: SettingScreen(
                    viewModel: SettingViewModel(
                      authRepository: context.read(),
                    ),
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // if the user is not logged in, they need to login
    final bool loggedIn = context.read<AuthRepository>().isAuthenticated;
    final bool loggingIn = state.matchedLocation == Routes.login.path;

    if (!loggedIn) {
      return Routes.login.path;
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) {
      return Routes.home.path;
    }

    // no need to redirect at all
    return null;
  }

  Widget _getStoredPage({
    required Routes routes,
    required GoRouterPageBuilder pageBuilder,
  }) {
    final hasPage = _pages.containsKey(routes.name);

    // If page exist
    if (hasPage) return _pages[routes.name]!;

    return pageBuilder();
  }
}

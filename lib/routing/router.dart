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
import 'package:todo/ui/auth/register/view_model/register_view_model.dart';
import 'package:todo/ui/auth/register/widget/register_screen.dart';
import 'package:todo/ui/setting/view_model/setting_view_model.dart';

typedef GoRouterPageBuilder = Widget Function();

class GoRoutereManager {
  GoRoutereManager._internal();

  static final GoRoutereManager _instance = GoRoutereManager._internal();

  static GoRoutereManager get instance => _instance;

  GoRouter getRouter(AuthRepository authRepository) {
    return GoRouter(
      redirect: _redirect,
      refreshListenable: authRepository,
      routes: [
        GoRoute(
          path: Routes.home.path,
          builder: (context, state) {
            return HomeScreen(
              viewModel: HomeViewModel(
                authRepository: context.read(),
                todoRepository: context.read(),
              ),
            );
          },
          routes: [
            GoRoute(
              path: Routes.setting.path,
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
        GoRoute(
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
          path: Routes.register.path,
          builder: (context, state) {
            return RegisterScreen(
              viewModel: RegisterViewModel(
                authRepository: context.read(),
              ),
            );
          },
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
      if (state.matchedLocation == Routes.register.path) {
        return Routes.register.path;
      }

      return Routes.login.path;
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) {
      return Routes.home.path;
    }

    return null;
  }
}

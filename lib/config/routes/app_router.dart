import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/config/routes/scaffold_with_nav_bar.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/login_page.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/otp_page.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/register_page.dart';
import 'package:fruit_jus_168/main.dart';
import 'package:fruit_jus_168/screens/home_page.dart';
import 'package:go_router/go_router.dart';

// _rootNavigatorKey will help us in all of the routes that are not suppose to have the persistent BottomNavigationBar
final _rootNavigatorKey = GlobalKey<NavigatorState>();
// _shellNavigatorKey will be used for all the routes that should have the BottomNavigationBar
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AuthBloc _authBloc;
  late final GoRouter _router;
  AppRouter(this._authBloc) {
    _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => ScaffoldWithNavBar(child: child),
          routes: [
            GoRoute(
              redirect: (context, state) {
                if (FirebaseAuth.instance.currentUser!.displayName != null) {
                  return "/";
                } else {
                  return "/register";
                }
              },
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRouterConstants.homeRouteName,
              path: '/',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: HomePage(title: 'Home Page Demo'),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRouterConstants.menuRouteName,
              path: '/menu',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: MyHomePage(title: 'Menu Page Demo'),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRouterConstants.rewardsRouteName,
              path: '/rewards',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: MyHomePage(title: 'Rewards Page Demo'),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRouterConstants.accountRouteName,
              path: '/account',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: MyHomePage(title: 'Account Page Demo'),
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: AppRouterConstants.loginRouteName,
          path: '/login',
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          name: AppRouterConstants.otpRouteName,
          path: '/otp/:phoneNumber/:verificationId',
          builder: (context, state) {
            final phoneNumber = state.pathParameters['phoneNumber']!;
            final verificationId = state.pathParameters['verificationId']!;
            return OtpPage(
                phoneNumber: phoneNumber, verificationId: verificationId);
          },
        ),
        GoRoute(
          name: AppRouterConstants.registerRouteName,
          path: '/register',
          builder: (context, state) {
            return const RegisterPage();
          },
        ),
      ],
      refreshListenable: GoRouterRefreshStream(_authBloc.stream),
    );
  }
  get router => _router;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

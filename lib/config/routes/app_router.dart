import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/config/routes/scaffold_with_nav_bar.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/login_page.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/otp_page.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/register_page.dart';
import 'package:fruit_jus_168/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:fruit_jus_168/main.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:fruit_jus_168/features/profile/presentation/pages/profile_page.dart';

// _rootNavigatorKey will help us in all of the routes that are not suppose to have the persistent BottomNavigationBar
final _rootNavigatorKey = GlobalKey<NavigatorState>();
// _shellNavigatorKey will be used for all the routes that should have the BottomNavigationBar
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ScaffoldWithNavBar(child: child),
      routes: [
        GoRoute(
          redirect: (context, state) {
            if (context.read<AuthBloc>().state.firebaseUser?.displayName !=
                null) {
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
              child: ProfilePage(profile: null),
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
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRouterConstants.editProfileRouteName,
      path: '/edit-profile',
      builder: (context, state) {
        return const EditProfilePage(profile: null);
      },
    ),
  ],
);

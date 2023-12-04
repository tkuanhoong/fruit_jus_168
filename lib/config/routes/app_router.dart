import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/config/routes/scaffold_with_nav_bar.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/login_page.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/otp_page.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/register_page.dart';
import 'package:fruit_jus_168/features/menu_details/presentation/pages/beverage_details.dart';
import 'package:fruit_jus_168/features/menu/presentation/pages/menu_page.dart';
import 'package:fruit_jus_168/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:fruit_jus_168/features/profile/presentation/pages/referral_code_page.dart';
import 'package:fruit_jus_168/main.dart';
import 'package:fruit_jus_168/features/auth/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:fruit_jus_168/features/profile/presentation/pages/profile_page.dart';
import 'package:fruit_jus_168/features/address/presentation/pages/add_address_page.dart';
import 'package:fruit_jus_168/features/address/presentation/pages/address_page.dart';
import 'package:fruit_jus_168/features/address/presentation/pages/edit_address_page.dart';
import 'package:fruit_jus_168/features/address/presentation/pages/open_map_page.dart';

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
              child: MenuPage(),
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
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRouterConstants.referralCodePageRouteName,
      path: '/referral-code',
      builder: (context, state) {
        return const ReferralCodePage(profile: null);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRouterConstants.beverageDetailsRouteName,
      path: '/beverageDetails',
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: BeverageDetailsPage(beverage: null),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRouterConstants.addressRouteName,
      path: '/address',
      builder: (context, state) {
        return const AddressPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRouterConstants.openMapRouteName,
      path: '/open-map',
      builder: (context, state) {
        return const OpenMapPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRouterConstants.addAddressRouteName,
      path: '/add-address/:streetName/:city/:postalCode/:state/:country',
      builder: (context, state) {
        final streetName = state.pathParameters['streetName'];
        final city = state.pathParameters['city'];
        final postalCode = state.pathParameters['postalCode'];
        final state_ = state.pathParameters['state'];
        final country = state.pathParameters['country'];
        return AddAddressPage(
          streetName: streetName,
          city: city,
          postalCode: postalCode,
          state_: state_,
          country: country,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRouterConstants.editAddressRouteName,
      path: '/edit-address',
      builder: (context, state) {
        return const EditAddressPage();
      },
    ),
  ],
);

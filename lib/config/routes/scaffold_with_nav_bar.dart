import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/utility/dialog_display.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:go_router/go_router.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.0,
        unselectedItemColor: Colors.grey[350],
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.loyalty),
            label: "Rewards",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: "Account",
          )
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/menu')) {
      return 1;
    }
    if (location.startsWith('/rewards')) {
      return 2;
    }
    if (location.startsWith('/account')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRouterConstants.homeRouteName);
        break;
      case 1:
        if (context.read<CartBloc>().state.cart!.fulfillMethod == null) {
          displayDeliveryPickUpDialog(context);
          return;
        }
        context.goNamed(AppRouterConstants.menuRouteName);

        break;
      case 2:
        context.goNamed(AppRouterConstants.rewardsRouteName);
        break;
      case 3:
        context.goNamed(AppRouterConstants.accountRouteName);
        break;
    }
  }
}

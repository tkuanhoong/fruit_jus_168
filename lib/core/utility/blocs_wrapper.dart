import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/features/address/presentation/bloc/address_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruit_jus_168/features/profile/presentation/bloc/profile_bloc.dart';

// A wrapper to wrap the app with the blocs providers
class BlocsWrapper extends StatelessWidget {
  final Widget child;
  const BlocsWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => sl<ProfileBloc>(),
        ),
        BlocProvider<AddressBloc>(
          create: (_) => sl<AddressBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => sl<CartBloc>(),
        ),
      ],
      child: child,
    );
  }
}

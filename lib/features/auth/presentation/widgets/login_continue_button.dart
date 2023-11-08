// import 'dart:html';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginContinueButton extends StatelessWidget {
  final TextEditingController phoneController;
  const LoginContinueButton({required this.phoneController, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: 20, left: 25, right: 25),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                String phoneNumber = "+60" + phoneController.text;
                context
                    .read<AuthBloc>()
                    .add(AuthOtpRequested(phoneNumber: phoneNumber));
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

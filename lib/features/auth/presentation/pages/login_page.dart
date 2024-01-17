import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/login_continue_button.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/login_textfield.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthCodeSentState) {
          context.pushNamed(AppRouterConstants.otpRouteName, pathParameters: {
            'phoneNumber': phoneController.text,
            'verificationId': state.verificationId
          });
        }
      },
      child: Scaffold(
        //appbar with title login signup
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Login or Sign Up',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        //body with brand logo at the top center and textfield for phone number
        body: SingleChildScrollView(
          // boxdecoration boxfitcover background image
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: const Text(
                  "Welcome to 168 Jus!",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                      fontFamily: 'Mulish'),
                ),
              ),
              //brand logo
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 50),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Container(
                child: const Text(
                  "Enter your phone number",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor),
                ),
              ),
              //text field for phone number
              LoginTextFormField(
                phoneController: phoneController,
                loginformKey: _loginformKey,
              ),
              //Continue button
              LoginContinueButton(
                phoneController: phoneController,
                loginformKey: _loginformKey,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              //a "Terms of Service" text at bottom of the page
              Container(
                width: 180,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text:
                                'By Logging in or registering, you agree to our'),
                        TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(text: ' and '),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    minFontSize: 9,
                    maxFontSize: 16,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const Text('Version 1.0.0',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

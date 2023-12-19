import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/71/52/56/71525601b8a06435f323cf39bca1710b.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                //brand logo
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 100,
                      width: 100,
                    ),
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
                //a "By continuing, you agree to our Terms of Service and Privacy Policy" text at bottom of the page
                const Padding(
                  padding: EdgeInsets.only(top: 220, left: 25, right: 25),
                  child: Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

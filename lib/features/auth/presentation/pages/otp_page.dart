import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpPage(
      {super.key, required this.phoneNumber, required this.verificationId});
  @override
  createState() => _OtpPage();
}

class _OtpPage extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();
  late int _secondsToResendOTP;
  String? _otp;
  bool? _validOtp;
  Timer? _timer;
  late final String _phoneNumber;
  late final String verificationId = widget.verificationId;
  final GlobalKey<FormState> _otpformKey = GlobalKey<FormState>();

  void startTimer() {
    _secondsToResendOTP = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsToResendOTP--;
      });
      if (_secondsToResendOTP == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    _phoneNumber = widget.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void _verifyOtp({required BuildContext context}) {
    context.read<AuthBloc>().add(AuthOtpPendingVerified(
        otpCodeReceived: _otp!, verificationId: verificationId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) {
        if (state is AuthCodeVerifiedState) {
          _timer!.cancel();
          context.goNamed(AppRouterConstants.homeRouteName);
        }
        if (state is AuthVerifyFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        //appbar with title centered
        appBar: AppBar(
          //back button
          centerTitle: true,
          title: const Text(
            'SMS Confirmation',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        //body with brand logo at the top center and textfield for OTP
        body: SingleChildScrollView(
          child: Column(
            children: [
              //brand logo here
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
              ////////////////////////////////////////////Textfield for OTP
              Form(
                key: _otpformKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter OTP';
                      } else if (value.length < 6) {
                        return 'Please enter a valid OTP';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 178, 223, 105),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock_clock_outlined),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      //input hint text
                      hintText: 'Enter your OTP Code Here',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'sans-serif',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 192, 192, 192),
                      ),
                    ),
                  ),
                ),
              ),
              //////////////////////////////////////////////////OTP submit button
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
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
                      if (_otpformKey.currentState!.validate()) {
                        setState(
                          () {
                            setState(() {
                              _validOtp = otpController.text.trim().length == 6;
                            });
                            if (_validOtp == true) {
                              _otp = otpController.text.trim();
                              _verifyOtp(context: context);
                            }
                          },
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              if (_secondsToResendOTP > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Text('Resend OTP (${_secondsToResendOTP}s)',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Didn\'t receive the OTP?',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.2,
                        fontSize: 14.0,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          String phoneNumber = "+60$_phoneNumber";
                          startTimer();
                          context
                              .read<AuthBloc>()
                              .add(AuthOtpRequested(phoneNumber: phoneNumber));
                        },
                        child: const Text('Resend OTP')),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

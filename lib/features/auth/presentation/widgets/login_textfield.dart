import 'package:flutter/material.dart';

class LoginTextFormField extends StatefulWidget {
  final TextEditingController phoneController;
  final GlobalKey<FormState> loginformKey;

  const LoginTextFormField({
    Key? key,
    required this.loginformKey,
    required this.phoneController,
  }) : super(key: key);
  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginformKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your phone number';
            } else if (value.length < 7) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
          controller: widget.phoneController,
          keyboardType: TextInputType.number,
          maxLength: 10,
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
            prefixIcon: Icon(Icons.phone_android_outlined),
            prefixText: '+60 ',
            prefixStyle: TextStyle(
              fontSize: 16,
            ),
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            //input hint text
            hintText: 'Example: 12 3xx 6xxx',
            hintStyle: TextStyle(
              fontSize: 13,
              fontFamily: 'sans-serif',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 192, 192, 192),
            ),
          ),
        ),
      ),
    );
  }
}

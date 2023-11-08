import 'package:flutter/material.dart';

class login_textfield extends StatelessWidget {
  final TextEditingController phoneController;
  login_textfield({required this.phoneController, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 25, right: 25),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.number,
        maxLength: 10,
        //prefix text "+60" with same style with input
        decoration: InputDecoration(
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
          hintText: 'Example: 12 xxx xxxx',
          hintStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'sans-serif',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 192, 192, 192),
          ),
        ),
      ),
    );
  }
}

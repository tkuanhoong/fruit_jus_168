import 'package:flutter/material.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final Function()? onTap;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      this.labelText,
      this.prefixIcon,
      this.validator,
      this.onTap,
      this.readOnly = false,
      this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(50.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(50.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: Colors.white,
        ),
        // The validator receives the text that the user has entered.
        validator: validator,
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextFieldValidator {
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter Full Name';
    }
    if (value.trim().characters.length < 6 ||
        value.trim().characters.length > 50) {
      return 'Please enter between 6 and 50 characters';
    }
    return null;
  }

  static String? emailAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter Email Address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid Email Address';
    }
    return null;
  }

  static String? dob(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter Date of Birth';
    }
    return null;
  }
}

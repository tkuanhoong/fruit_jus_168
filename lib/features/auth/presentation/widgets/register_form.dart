import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/components/custom_text_field.dart';
import 'package:fruit_jus_168/core/errors/text_field_validator.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController referralCodeController;
  const RegisterForm(
      {super.key,
      required this.formKey,
      required this.fullNameController,
      required this.emailController,
      required this.dobController,
      required this.referralCodeController
      }
    );

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  void displayDatePicker() async {
    // set 100 years date range
    const dateRange = 36500;
    final now = DateTime.now();
    final dob = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now.subtract(const Duration(days: dateRange)),
        lastDate: now);
    if (dob != null) {
      setState(() {
        widget.dobController.text = DateFormat('dd-MM-yyyy').format(dob);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          const SizedBox(height: 30),
          CustomTextField(
            controller: widget.fullNameController,
            labelText: 'Full Name',
            prefixIcon: Icons.face,
            validator: TextFieldValidator.fullName,
          ),
          CustomTextField(
              controller: widget.emailController,
              labelText: 'Email Address',
              prefixIcon: Icons.email_outlined,
              validator: TextFieldValidator.emailAddress),
          CustomTextField(
            controller: widget.dobController,
            onTap: displayDatePicker,
            labelText: "Date of Birth",
            readOnly: true,
            prefixIcon: Icons.cake_outlined,
            validator: TextFieldValidator.dob,
          ),
          CustomTextField(
            controller: widget.referralCodeController,
            labelText: "Referral Code",
            prefixIcon: Icons.discount_outlined,
          ),
        ],
      ),
    );
  }
}

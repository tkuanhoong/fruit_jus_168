import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/components/custom_text_field.dart';
import 'package:fruit_jus_168/core/errors/text_field_validator.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const RegisterForm({super.key, required this.formKey});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  void dispose() {
    // dispose all controllers
    fullNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.dispose();
  }

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
        dobController.text = DateFormat('dd-MM-yyyy').format(dob);
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
            controller: fullNameController,
            labelText: 'Full Name',
            prefixIcon: Icons.face,
            validator: TextFieldValidator.fullName,
          ),
          CustomTextField(
              controller: emailController,
              labelText: 'Email Address',
              prefixIcon: Icons.email_outlined,
              validator: TextFieldValidator.emailAddress),
          CustomTextField(
            controller: dobController,
            onTap: displayDatePicker,
            labelText: "Date of Birth",
            readOnly: true,
            prefixIcon: Icons.cake_outlined,
            validator: TextFieldValidator.dob,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/components/common_app_bar.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/register_form.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
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

  Future<void> _submitForm() async {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      // save user info in database.
      context.read<AuthBloc>().add(
            SaveUserInfo(
                fullName: fullNameController.text,
                email: emailController.text,
                dateOfBirth: DateFormat('dd-MM-yyyy').parse(dobController.text),
                phoneNumber:
                    context.read<AuthBloc>().state.firebaseUser!.phoneNumber!),
          );
    } else {
      // Clear previous snackbar
      ScaffoldMessenger.of(context).clearSnackBars();
      // Display a snackbar to the user with the missing fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form to continue.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // If user info is saved successfully, navigate to home page.
        if (state is UserInfoSavedSuccess) {
          context.goNamed(AppRouterConstants.homeRouteName);
        }
      },
      child: Scaffold(
        appBar: const CommonAppBar(title: "Register"),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Image(
                    height: 200,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  RegisterForm(
                    formKey: _formKey,
                    fullNameController: fullNameController,
                    emailController: emailController,
                    dobController: dobController,
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

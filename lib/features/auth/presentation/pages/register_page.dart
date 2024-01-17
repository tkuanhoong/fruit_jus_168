import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/components/common_app_bar.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/register_form.dart';
import 'package:fruit_jus_168/features/reward/data/datasources/new_voucher_generator.dart';
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
  final TextEditingController referralCodeController = TextEditingController();
  final NewVoucherGeneratorService voucherService = NewVoucherGeneratorService();
  String validationMessage = '';
  
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
      // Get the current user ID
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the referrer user ID from Firebase if referral code is provided
      String? referrerUserId;
      bool isReferralCodeProvided = referralCodeController.text.isNotEmpty;
      bool isValidReferralCode = false;  // Initialize isValidReferralCode

      if (isReferralCodeProvided) {
      referrerUserId = await fetchReferrerUserId(referralCodeController.text);

      print('Referral code provided. Voucher generation block.');

      // Check if the referral code exists in Firebase and belongs to a different user
      isValidReferralCode = await validateReferralCodeInFirebase(
        currentUserId,
        referralCodeController.text,
      );

      // Handle referral code validation result
      if (!isValidReferralCode) {
        print('Invalid referral code. Please try again.');
        // Display an error message if needed
        setState(() {
          validationMessage = 'Invalid referral code. Please try again.';
        });
        return; // Stop further processing
      }
    }

      // save user info in database.
      context.read<AuthBloc>().add(
            SaveUserInfo(
                fullName: fullNameController.text,
                email: emailController.text,
                dateOfBirth: DateFormat('dd-MM-yyyy').parse(dobController.text),
                phoneNumber:
                    context.read<AuthBloc>().state.firebaseUser!.phoneNumber!,
                referralCode: isReferralCodeProvided ? referralCodeController.text : '',
                referrerUserId: referrerUserId ?? '',
            ),
          );
          if (isReferralCodeProvided && isValidReferralCode) {
          // Use your NewVoucherGeneratorService to generate and apply a coupon
          NewVoucherGeneratorService voucherService = NewVoucherGeneratorService();
          voucherService.createNewVoucher(currentUserId, referralCode: referralCodeController.text.trim());

          // Fetch the referrer user ID from Firebase
          String? referrerUserId = await fetchReferrerUserId(referralCodeController.text);

          // Now, update the referrer's history in Firebase
          if (referrerUserId.isNotEmpty) {
            await updateReferrerHistory(referrerUserId, currentUserId);
          }
          // For now, let's print a message indicating that a coupon would be applied
          print('Coupon applied successfully!');
        } else {
          // If no referral code is provided, you may want to print a message or handle it as needed
          print('No referral code provided. No voucher generated.');
        }
    } else {
      // Clear previous snackbar
      ScaffoldMessenger.of(context).clearSnackBars();
      // Display a snackbar to the user with the missing fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form to continue.')),
      );
    }
  }

Future<bool> validateReferralCodeInFirebase(String currentUserId, String referralCode) async {
    try {
      // Check if the referral code exists in Firebase for a different user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userRefferalCode', isEqualTo: referralCode.trim())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String referringUserId = querySnapshot.docs.first.id;

        // Check if the referring user is not the same as the current user
        return referringUserId != currentUserId;
      } else {
        print('Referral code not found in Firebase.');
      }

      return false; // Invalid referral code
    } catch (e) {
      print('Error validating referral code: $e');
      return false;
    }
  }
  
  // Function to fetch the referrer user ID from Firebase
Future<String> fetchReferrerUserId(String referralCode) async {
  try {
    // Query Firebase to get the referrer user ID based on the referral code
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userRefferalCode', isEqualTo: referralCode.trim())
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      print('Referrer user not found in Firebase.');
    }

    return ''; // Handle the case where referrer user is not found
  } catch (e) {
    print('Error fetching referrer user ID: $e');
    return ''; // Handle the error case
  }
}

// Define the updateReferrerHistory method in the _RegisterPageState class
Future<void> updateReferrerHistory(String referrerUserId, String referredUserId) async {
  try {
    // Your logic to update referrer's history in Firebase
    // Example: Get the referrer's document reference and update the history field
    DocumentReference referrerDocRef = FirebaseFirestore.instance.collection('users').doc(referrerUserId);

    await referrerDocRef.update({
      'referrerHistory': FieldValue.arrayUnion([referredUserId]),
    });

    print('Referrer history updated successfully');
  } catch (e) {
    print('Error updating referrer history: $e');
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
                    referralCodeController: referralCodeController,

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

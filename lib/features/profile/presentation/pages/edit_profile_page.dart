import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/errors/text_field_validator.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/profile/domain/entities/profile.dart';
import 'package:fruit_jus_168/features/profile/presentation/bloc/profile_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.profile});
  final ProfileEntity? profile;
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _updateProfileFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
  }

  //final controllerName =
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Edit Profile',
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final controllerName =
                  TextEditingController(text: state.profile.fullName ?? '');
              final controllerEmail =
                  TextEditingController(text: state.profile.emailAddress ?? '');
              final controllerdateOfBirth =
                  DateFormatGenerator.getFormattedDateTime(
                      state.profile.dateOfBirth!.toIso8601String(),
                      'dd-MM-yyyy');

              final controllerPhoneNum =
                  TextEditingController(text: state.profile.phoneNumber);

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage: state.profile.avatarURL != null
                                ? CachedNetworkImageProvider(
                                    state.profile.avatarURL!)
                                : const AssetImage(
                                        "assets/images/default_avatar.png")
                                    as ImageProvider<Object>?,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipOval(
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                ),
                                child: IconButton(
                                  iconSize: 18,
                                  icon: const Icon(Icons.edit),
                                  color: Colors.grey,
                                  onPressed: () {
                                    getImageFromDevice();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: _updateProfileFormKey,
                        child: Column(children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: TextFieldValidator.fullName,
                            controller: controllerName,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
                                color: Colors.black,
                              ),
                              labelStyle: const TextStyle(color: Colors.black),
                            ),
                          ),

                          const SizedBox(height: 15.0),

                          TextFormField(
                            readOnly: true,
                            controller: controllerEmail,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIcon: const Icon(
                                Icons.email_rounded,
                                color: Colors.black,
                              ),
                              labelStyle: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          TextFormField(
                            readOnly: true,
                            initialValue: controllerdateOfBirth,
                            decoration: InputDecoration(
                              labelText: 'Birthday',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIcon: const Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.black,
                              ),
                              labelStyle: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          //phoneNumber
                          TextFormField(
                            readOnly: true,
                            controller: controllerPhoneNum,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIcon: const Icon(
                                Icons.phone_android_rounded,
                                color: Colors.black,
                              ),
                              labelStyle: const TextStyle(color: Colors.black),
                            ),
                          ),

                          const SizedBox(height: 15.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                User? user = FirebaseAuth.instance.currentUser;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user?.uid)
                                    .update({
                                  "fullName": controllerName.text,
                                }).then((value) {
                                  //controllerName.text = '';
                                });
                                _showMyDialog();
                                context.read<AuthBloc>().add(SaveUserInfo(
                                    fullName: controllerName.text,
                                    email: controllerEmail.text,
                                    dateOfBirth: DateFormat('dd-MM-yyyy')
                                        .parse(controllerdateOfBirth),
                                    phoneNumber: controllerPhoneNum.text, 
                                    referralCode: '', 
                                    referrerUserId: ''));
                              },
                              child: const Text('UPDATE'),
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ));
  }

  getImageFromDevice() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // return pickedFile.path;
        BlocProvider.of<ProfileBloc>(context)
            .add(UploadAvatar(imagePath: pickedFile.path));
      }
    } catch (e) {
      print('Error picking image: $e');
    }

    return null;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SUCCESS'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your profile has been updated'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                context.goNamed(AppRouterConstants.accountRouteName);
                BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
              },
            ),
          ],
        );
      },
    );
  }
}

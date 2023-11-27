import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/core/components/card_items.dart';
import 'package:fruit_jus_168/features/auth/data/models/user.dart';
import 'package:fruit_jus_168/features/profile/data/models/profile.dart';
import 'package:fruit_jus_168/features/profile/domain/entities/profile.dart';
import 'package:fruit_jus_168/features/profile/presentation/bloc/profile_bloc.dart';

class ReferralCodePage extends StatefulWidget {
  const ReferralCodePage({super.key, required this.profile});
  final ProfileEntity? profile;
  @override
  State<ReferralCodePage> createState() => _ReferralCodePageState();
}

class _ReferralCodePageState extends State<ReferralCodePage> {
  @override
  void initState() {
    super.initState();
    //BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Referral Program',
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final controllerReferralCode = TextEditingController(
                text: state.profile.userReferralCode ?? '');
            return Column(
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: CardStack(),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: controllerReferralCode,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100))),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          String enteredText =
                              controllerReferralCode.text.trim();
                          if (enteredText.isNotEmpty) {
                            Clipboard.setData(ClipboardData(text: enteredText));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Text copied to clipboard'),
                              ),
                            );
                          }
                        },
                        child: const Text('Copy'),
                      ),
                    ],
                  ),
                ),
                Container(),
                const SizedBox(height: 100),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle link tap action
                      print('Link tapped!');
                    },
                    child: const Text(
                      'Invite more & get more vouchers >>>>',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Unknown state'));
        }));
  }
}
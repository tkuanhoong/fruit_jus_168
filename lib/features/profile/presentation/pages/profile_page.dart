import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/profile/domain/entities/profile.dart';
import 'package:fruit_jus_168/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.profile});
  final ProfileEntity? profile;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogOutRequested());
              context.goNamed(AppRouterConstants.loginRouteName);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
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
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (context
                                      .watch<AuthBloc>()
                                      .state
                                      .firebaseUser !=
                                  null)
                                Text(
                                  context
                                          .watch<AuthBloc>()
                                          .state
                                          .firebaseUser!
                                          .displayName ??
                                      'User Name',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              Text(
                                state.profile.phoneNumber ?? '601123456789',
                                style: const TextStyle(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Text(
                          'My Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text(
                        'Edit Profile',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        // Handle the action on tapping "Edit Profile"
                        GoRouter.of(context).push('/edit-profile');
                      },
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart_outlined),
                      title: const Text(
                        'Orders',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        // Handle the action on tapping "Orders"
                        GoRouter.of(context).push('/order-history');
                      },
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'Setting',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        // Handle the action on tapping "Setting"
                        GoRouter.of(context).push('/address');
                      },
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text(
                        'Invite Your Friends',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        // Handle the action on tapping "Invite Your Friends"
                        GoRouter.of(context).push('/referral-code');
                      },
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
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
}

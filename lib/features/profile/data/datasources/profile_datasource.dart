import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fruit_jus_168/features/profile/data/models/profile.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getProfileData();
  Future<void> uploadAvatar(String imagePath);
}

class FirebaseProfileDataSource implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseProfileDataSource({required this.firestore, required this.storage});

  @override
  Future<ProfileModel> getProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .doc(user.uid) // Use the UID of the current user
          .get();

      if (snapshot.exists) {
        // Check if the document exists
        return ProfileModel.fromMap(snapshot.data()!);
      } else {
        // Return a default profile or throw an exception as per your requirement
        throw Exception('Profile not found');
      }
    } else {
      // Handle the case where no user is currently logged in
      throw Exception('No user logged in');
    }
  }

  @override
  Future<void> uploadAvatar(String imagePath) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Delete user's current image in Firebase Storage if it exists
        DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
            .collection('users')
            .doc(user.uid) // Use the UID of the current user
            .get();

        // String avatarURLInFirestore = snapshot.data()?['avatarURL'];
        if (snapshot.exists &&
            snapshot.data() != null &&
            snapshot.data()!['avatarURL'] != null) {
          String avatarURLInFirestore = snapshot.data()!['avatarURL'];
          await storage.refFromURL(avatarURLInFirestore).delete();
          // Check if the avatarURL in Firestore is not the same as user.photoURL
          // if (user.photoURL != null && user.photoURL != avatarURLInFirestore) {
          //   await storage.refFromURL(avatarURLInFirestore).delete();
          // }
        }

        // Upload image to Firebase Storage
        String fileName =
            'avatars/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference storageReference = storage.ref().child(fileName);
        UploadTask uploadTask = storageReference.putFile(File(imagePath));
        await uploadTask.whenComplete(() async {
          // Get the uploaded image URL
          String downloadURL = await storageReference.getDownloadURL();

          // Update the user's document with the new avatarURL
          await firestore.collection('users').doc(user.uid).update({
            'avatarURL': downloadURL,
          });
        });
      } catch (e) {
        throw Exception('Failed to upload avatar: $e');
      }
    } else {
      throw Exception('No user logged in');
    }
  }
}

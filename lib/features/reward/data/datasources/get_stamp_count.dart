import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StampFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getStamp() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentReference userDocRef =
            _firestore.collection('users').doc(user.uid);
        DocumentSnapshot userDoc = await userDocRef.get();

        if (userDoc.exists) {
          // Access the "stamp" data and return it as an integer
          int stamp = userDoc.get('stamp') as int;
          return stamp;
        } else {
          // Handle the case where the user document doesn't exist
          print('User document does not exist.');
          return 0; // Or return a default value as needed
        }
      } else {
        // Handle the case where the user is not signed in
        print('User is not signed in.');
        return 0; // Or return a default value as needed
      }
    } catch (error) {
      // Handle any errors that may occur during the retrieval
      print('Error retrieving stamp: $error');
      return 0; // Or return a default value as needed
    }
  }

  Future<void> countStamp() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the user's document reference
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.uid);

      // Get the current stamp count
      DocumentSnapshot userDoc = await userDocRef.get();
      int currentStampCount = userDoc['stamp'];

      // Increment the count by 1
      int newStampCount = currentStampCount++;

      // Update the 'stamp' field in Firestore
      await userDocRef.update({'stamp': newStampCount});

      print('Stamp count updated successfully.');
    } else {
      print('User not logged in.');
    }
  }
}

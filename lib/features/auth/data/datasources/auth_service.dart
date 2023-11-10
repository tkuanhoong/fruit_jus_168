part of 'auth_api_service.dart';

class _AuthService implements AuthApiService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  _AuthService(this._auth, this._db);

  @override
  Future<void> verifyPhone(Map<String, dynamic> data) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: data['phoneNumber'],
      timeout: const Duration(minutes: 2),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        data['verificationCompleted']();
      },
      verificationFailed: (FirebaseAuthException e) {
        data['verificationFailed'](e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        data['codeSent'](verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('TimeOut');
      },
    );
  }

  @override
  Future<void> storeUserInfo(UserModel user) async {
    try {
      await _auth.currentUser!.updateDisplayName(user.fullName);
      DocumentReference userRef =
          _db.collection("users").doc(_auth.currentUser!.uid);
      // set the generated id to user id
      user = user.copyWith(id: _auth.currentUser!.uid);
      await userRef.set(user.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> verifyOtp(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> logOut() async {
    await _auth.signOut();
  }
}

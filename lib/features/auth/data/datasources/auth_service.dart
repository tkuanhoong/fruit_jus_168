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
      DocumentReference userRef = _db.collection("users").doc();
      // set the generated id to user id
      user = user.copyWith(id: userRef.id);
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
    await _auth
        .signInWithCredential(credential)
        .then((value) => print('User Login In Successful'));
  }
}

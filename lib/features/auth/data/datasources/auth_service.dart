part of 'auth_api_service.dart';

class _AuthService implements AuthApiService {
  final FirebaseFirestore _db;
  _AuthService(this._db);
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
}

part of "order_history_api_service.dart";

class _OrderHistoryService implements OrderHistoryApiService {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  _OrderHistoryService(this._db, this._auth);

  @override
  Stream<List<OrderHistoryModel>> getOrderList() {
    final user = _auth.currentUser;

    return _db
        .collection("users")
        .doc(user!.uid)
        .collection("orders")
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OrderHistoryModel.fromMap(doc.data());
      }).toList();
    });
  }
}

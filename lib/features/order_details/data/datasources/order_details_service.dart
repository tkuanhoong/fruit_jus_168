part of 'order_details_api_service.dart';

class _OrderDetailsService implements OrderDetailsApiService {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  _OrderDetailsService(this._db, this._auth);

  @override
  Stream<OrderDetailsModel> getOrderDetails(String orderId) {
    final userId = _auth.currentUser!.uid;
    final orderDocRef =
        _db.collection("users").doc(userId).collection("orders").doc(orderId);

    return orderDocRef.snapshots().asyncMap((doc) async {
      if (!doc.exists) {
        throw Exception("Order not found");
      }
      final orderData = doc.data();
      final itemsSnapshot = await orderDocRef.collection("items").get();
      final itemsList = itemsSnapshot.docs.map((doc) => doc.data()).toList();

      // Create and return OrderDetailsModel
      return OrderDetailsModel.fromMap({
        'order': orderData,
        'items': itemsList,
      });
    });
  }
}

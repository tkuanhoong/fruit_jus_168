part of "order_api_service.dart";

class _OrderService implements OrderApiService {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  _OrderService(this._db, this._auth);
  @override
  Future<void> makeOrder(OrderModel order) async {
    final userId = _auth.currentUser!.uid;
    final userDocRef = _db.collection('users').doc(userId);
    final orderMap = order.toMap();
    final items = orderMap.remove("items");
    String generatedOrderId = '';
    await userDocRef.collection('orders').add(orderMap).then((doc) {
      doc.update({"id": doc.id});
      generatedOrderId = doc.id;
    });

    // Batch write
    final batch = _db.batch();

    for (var item in items) {
      final newItem = userDocRef
          .collection("orders")
          .doc(generatedOrderId)
          .collection("items")
          .doc();
      batch.set(
        newItem, // Firestore will generate a random ID for the item
        CartProductModel.fromEntity(item.copyWith(id: newItem.id)).toMap(),
      );
    }
    if (order.voucherCode != null) {
      final voucherDoc = await _db
          .collection('users')
          .doc(userId)
          .collection("vouchers")
          .where('code', isEqualTo: order.voucherCode)
          .get();

      batch.update(voucherDoc.docs.first.reference, {"isUsed": true});
    }

    batch.update(userDocRef, {"stamp": FieldValue.increment(1)});

    await batch.commit();
  }
}

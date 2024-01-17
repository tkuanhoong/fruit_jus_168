import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/order_history/data/models/order_history_model.dart';
part "order_history_service.dart";

abstract class OrderHistoryApiService {
  factory OrderHistoryApiService(FirebaseFirestore db, FirebaseAuth auth) =
      _OrderHistoryService;
  Stream<List<OrderHistoryModel>> getOrderList();
}

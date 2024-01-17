import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/core/data/models/order_model.dart';
import 'package:fruit_jus_168/features/cart/data/models/cart_product_model.dart';

part "order_service.dart";

abstract class OrderApiService {
  factory OrderApiService(FirebaseFirestore db, FirebaseAuth auth) =
      _OrderService;
  Future<void> makeOrder(OrderModel order);
}

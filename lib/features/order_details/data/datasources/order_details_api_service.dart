import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/cart/data/models/cart_product_model.dart';
import 'package:fruit_jus_168/features/order_details/data/models/order_details_model.dart';

part 'order_details_service.dart';

abstract class OrderDetailsApiService {
  factory OrderDetailsApiService(FirebaseFirestore db, FirebaseAuth auth) =
      _OrderDetailsService;
  Stream<OrderDetailsModel> getOrderDetails(String orderId);
}

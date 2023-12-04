import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/menu_details/domain/entities/beverage.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BeverageEntity>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('products').get();

      List<BeverageEntity> products = querySnapshot.docs
          .map((doc) => BeverageEntity(name: doc['name']))
          .toList();

      return products;
    } catch (e) {
      throw Exception('Errors fetching products: $e');
    }
  }
}

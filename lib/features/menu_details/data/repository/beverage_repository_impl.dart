import 'package:fruit_jus_168/features/menu_details/data/datasource/beverage_datasource.dart';
import 'package:fruit_jus_168/features/menu_details/domain/entities/beverage.dart';

class BeverageRepositoryImpl {
  final FirestoreService _firestoreService;

  // Inject the FirestoreService through the constructor
  BeverageRepositoryImpl(this._firestoreService);

  Future<List<BeverageEntity>> getProducts() async {
    try {
      // Call the getProducts method from FirestoreService
      List<BeverageEntity> products = await _firestoreService.getProducts();
      return products;
    } catch (e) {
      throw Exception('Errors fetching products: $e');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/menu/data/models/category.dart';
import 'package:fruit_jus_168/features/menu/data/models/product.dart';

part 'menu_service.dart';

abstract class MenuApiService {
  factory MenuApiService(FirebaseFirestore db) = _MenuService;
  Future<List<ProductModel>> fetchCategoryProducts(String category);
  Future<List<CategoryModel>> getAllCategories();
}

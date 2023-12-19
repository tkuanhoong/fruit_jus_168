import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/menu/domain/entities/category.dart';

abstract class MenuRepository {
  Future<List<Product>> fetchCategoryProducts(String category);
  Future<List<Category>> getAllCategories();
}

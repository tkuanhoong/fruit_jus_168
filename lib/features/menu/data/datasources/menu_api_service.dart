import 'package:fruit_jus_168/features/menu/data/models/category.dart';
import 'package:fruit_jus_168/features/menu/data/models/product.dart';

abstract class MenuApiService {
  Future<List<ProductModel>> fetchCategoryProducts(String category);
  Future<List<CategoryModel>> getAllCategories();
}

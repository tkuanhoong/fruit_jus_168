import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/menu/data/datasources/menu_api_service.dart';
import 'package:fruit_jus_168/features/menu/domain/entities/category.dart';
import 'package:fruit_jus_168/features/menu/domain/repositories/menu_repository.dart';

class MenuRepositoryImpl extends MenuRepository {
  final MenuApiService _menuApiService;

  MenuRepositoryImpl(this._menuApiService);

  @override
  Future<List<Product>> fetchCategoryProducts(String category) async {
    // Call the appropriate method on _menuApiService to fetch the products
    final productModels = await _menuApiService.fetchCategoryProducts(category);

    // Convert the result into a list of Product entities
    final products = productModels.map((model) => model.toEntity()).toList();

    // Return the list
    return products;
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final categoryModels = await _menuApiService.getAllCategories();
    final categories = categoryModels.map((model) => model.toEntity()).toList();
    return categories;
  }
}

import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/menu/domain/repositories/menu_repository.dart';

class GetCategoryProducts {
  final MenuRepository _menuRepository;

  GetCategoryProducts(this._menuRepository);

  Future<List<Product>> execute(String category) {
    return _menuRepository.fetchCategoryProducts(category);
  }
}

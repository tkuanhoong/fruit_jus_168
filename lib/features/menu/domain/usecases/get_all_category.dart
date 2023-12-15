import 'package:fruit_jus_168/features/menu/domain/entities/category.dart';
import 'package:fruit_jus_168/features/menu/domain/repositories/menu_repository.dart';

class GetAllCategories {
  final MenuRepository repository;

  GetAllCategories(this.repository);

  Future<List<Category>> execute() async {
    return await repository.getAllCategories();
  }
}

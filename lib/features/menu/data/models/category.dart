import 'package:fruit_jus_168/features/menu/data/models/product.dart';
import 'package:fruit_jus_168/features/menu/domain/entities/category.dart';

class CategoryModel {
  final String id;
  final String name;
  final List<ProductModel> products;
  final String imageUrl;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.products,
      required this.imageUrl});

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      products: products.map((product) => product.toEntity()).toList(),
      imageUrl: imageUrl,
    );
  }
}

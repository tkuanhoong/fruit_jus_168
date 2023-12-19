import 'package:fruit_jus_168/core/domain/entities/product.dart';

class Category {
  final String id;
  final String name;
  final List<Product> products;
  final String imageUrl;

  Category(
      {required this.id,
      required this.name,
      required this.products,
      required this.imageUrl});
}

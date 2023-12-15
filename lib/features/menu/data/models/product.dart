import 'package:fruit_jus_168/core/domain/entities/product.dart';

class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String category;
  final int price;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.price,
  });

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      imageUrl: imageUrl,
      description: description,
      category: category,
      price: price,
    );
  }

  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'price': price,
    };
  }
}

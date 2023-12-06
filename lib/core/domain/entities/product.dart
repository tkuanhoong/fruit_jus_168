import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final String? category;
  final int? price;
  const Product(
      {this.id,
      this.name,
      this.imageUrl,
      this.description,
      this.category,
      this.price});

  @override
  List<Object?> get props => [id, name, imageUrl, description, category, price];

  @override
  bool get stringify => true;
}

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final int? price;
  const Product(
      {this.id, this.name, this.imageUrl, this.description, this.price});

  @override
  List<Object?> get props => [id, name, imageUrl, description, price];

  @override
  bool get stringify => true;
}

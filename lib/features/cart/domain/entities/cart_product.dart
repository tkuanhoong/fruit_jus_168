import 'package:fruit_jus_168/core/domain/entities/product.dart';

class CartProduct extends Product {
  final int? quantity;
  final String? preference;

  const CartProduct({
    String? id,
    String? name,
    String? description,
    int? price,
    String? imageUrl,
    this.quantity,
    this.preference,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
        );

  int get totalItemPrice => price! * quantity!;

  CartProduct copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    String? imageUrl,
    int? quantity,
    String? preference,
  }) {
    return CartProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      preference: preference ?? this.preference,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, imageUrl, description, price, quantity, preference];
}

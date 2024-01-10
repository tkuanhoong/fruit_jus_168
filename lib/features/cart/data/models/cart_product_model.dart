import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';

class CartProductModel extends CartProduct {
  const CartProductModel({
    String? id,
    String? name,
    String? description,
    int? price,
    String? imageUrl,
    int? quantity,
    String? preference,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
          quantity: quantity,
          preference: preference,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'preference': preference,
    };
  }

  factory CartProductModel.fromEntity(CartProduct entity) {
    return CartProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      quantity: entity.quantity,
      preference: entity.preference,
    );
  }

  @override
  CartProductModel copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    String? imageUrl,
    int? quantity,
    String? preference,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      preference: preference ?? this.preference,
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'preference': preference,
    };
  }

  // fromMap
  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      preference: map['preference'],
    );
  }
}

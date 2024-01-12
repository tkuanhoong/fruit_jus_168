import 'dart:convert';

import 'package:fruit_jus_168/features/cart/data/models/cart_product_model.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';
import 'package:fruit_jus_168/features/order_details/domain/entities/order_details.dart';
import 'package:fruit_jus_168/features/order_history/data/models/order_history_model.dart';

class OrderDetailsModel extends OrderDetailsEntity {
  const OrderDetailsModel({required super.order, required super.items});

  @override
  List<Object> get props => [order, items];

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'order': OrderHistoryModel.fromEntity(order).toMap(),
      'items': items
          .map((item) => CartProductModel.fromEntity(item).toMap())
          .toList(),
    };
  }

  // fromMap
  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      order: OrderHistoryModel.fromMap(map['order'] as Map<String, dynamic>),
      items: (map['items'] as List<dynamic>)
          .map((item) => CartProductModel.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromJson(String source) =>
      OrderDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // fromEntity
  factory OrderDetailsModel.fromEntity(OrderDetailsEntity entity) {
    return OrderDetailsModel(
      order: entity.order,
      items: entity.items,
    );
  }
}

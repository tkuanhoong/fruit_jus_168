import 'dart:convert';

import 'package:fruit_jus_168/features/search/domain/entities/search_item.dart';

class SearchItemModel extends SearchItemEntity {
  const SearchItemModel({
    super.id,
    super.name,
    super.imageUrl,
    super.description,
    super.category,
    super.price,
  });

  // Function to edit model
  SearchItemModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    String? category,
    int? price,
  }) {
    return SearchItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }

  // Convert SearchItemModel to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'price': price,
    };
  }

  // Convert Map to SearchItemModel
  factory SearchItemModel.fromMap(Map<String, dynamic> map) {
    return SearchItemModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
    );
  }

  // Convert SearchItemModel to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON to SearchItemModel
  factory SearchItemModel.fromJson(String source) =>
      SearchItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert SearchItemModel to SearchItemEntity
  factory SearchItemModel.fromEntity(SearchItemEntity entity) {
    return SearchItemModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      description: entity.description,
      category: entity.category,
      price: entity.price,
    );
  }
}

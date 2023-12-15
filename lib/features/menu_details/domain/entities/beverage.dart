import 'package:fruit_jus_168/core/domain/entities/product.dart';

class BeverageEntity extends Product {
  const BeverageEntity({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    int? price,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          description: description,
          price: price,
        );
}

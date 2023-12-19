import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';
import 'package:fruit_jus_168/features/cart/presentation/widgets/item_image.dart';

class CartItem extends StatelessWidget {
  final CartProduct product;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  const CartItem({
    super.key,
    required this.product,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ItemImage(imageUrl: product.imageUrl!),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Quantity: ${product.quantity}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Ice Level: ${product.preference}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'RM ${PriceConverter.fromInt(product.totalItemPrice)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onEditPressed,
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: onDeletePressed,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

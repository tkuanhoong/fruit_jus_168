import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruit_jus_168/features/cart/presentation/widgets/cart_item.dart';
import 'package:fruit_jus_168/features/cart/presentation/widgets/divider_text.dart';
import 'package:go_router/go_router.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/cart_repository.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {

  final CartRepository _cartRepository = CartRepository();
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  _buildOrderSection() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) {
        // print('OrderConfirmationPage rebuilt with state: $state');
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CartLoaded) {
          log(state.cart!.items.toString());
          if (state.cart!.items.isEmpty) {
            return const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.remove_shopping_cart_outlined,
                    size: 50,
                  ),
                  Text('Your cart is empty'),
                  Text('Add some items to your cart'),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                for (final item in state.cart!.items)
                  CartItem(
                    product: item,
                    onEditPressed: () => context.pushNamed(
                    AppRouterConstants.beverageDetailsRouteName,
                    pathParameters: {'isEdit': 'true'},
                    queryParameters: {'quantity': '${item.quantity}', 'preference': '${item.preference}'},
                    extra: item, // Ensure item is of type Product
                    ),
                    onDeletePressed: () {
                      if (state.cart != null && state.cart!.items.isNotEmpty) {
                        _cartRepository.showDeleteConfirmationDialog(context, state.cart!.items.first);
                      }
                    },
                  )
              ],
            );
          }
        }
        return const SizedBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerText(
                title: 'Delivery To / Pickup At',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              const DividerText(
                title: 'Your Order',
              ),
              _buildOrderSection(),
              const SizedBox(height: 16),
              const DividerText(
                title: 'Special Remarks',
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your special remarks here',
                  border: OutlineInputBorder(),
                ),
              ),
              const DividerText(
                title: 'Vouchers',
              ),
              const DividerText(
                title: 'Payment Details',
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount'),
                      Text('RM xx.xx'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee'),
                      Text('RM xx.xx'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount'),
                      Text('RM xx.xx'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total'),
                      Text('RM xx.xx'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    '${context.watch<CartBloc>().state.cart!.totalItemsQuantity} items',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'RM ${PriceConverter.fromInt(context.watch<CartBloc>().state.cart!.totalPrice)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Order Now'),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

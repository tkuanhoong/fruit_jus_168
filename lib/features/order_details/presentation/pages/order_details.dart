import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/cart/presentation/widgets/cart_item.dart';
import 'package:fruit_jus_168/features/order_details/presentation/bloc/order_details_bloc.dart';
import 'package:fruit_jus_168/features/order_details/presentation/widgets/order_payment.dart';
import 'package:fruit_jus_168/features/order_details/presentation/widgets/order_status_card.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track your order'),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderDetailsError) {
            return Center(child: Text(state.message));
          }
          if (state is OrderDetailsLoaded) {
            final order = state.orderDetails.order;
            final items = state.orderDetails.items;
            return SingleChildScrollView(
              child: Column(
                children: [
                  OrderStatusCard(
                    order: order,
                  ),
                  const Divider(
                    thickness: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Items',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        for (final item in items)
                          CartItem(
                            product: item,
                          ),
                        const Divider(
                          thickness: 2,
                        ),
                        if (order.note != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Remark',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                order.note!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                            ],
                          ),
                        Text(
                          'Payment Details',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        OrderPayment(order: order),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

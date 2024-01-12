import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';
import 'package:fruit_jus_168/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:fruit_jus_168/features/order_history/presentation/widgets/no_order_histroy_card.dart';
import 'package:fruit_jus_168/features/order_history/presentation/widgets/order_card.dart';
import 'package:go_router/go_router.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          if (state is OrderHistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OrderHistoryError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is OrderHistoryLoaded) {
            return _buildOrderHistoryCards(state.orders);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildOrderHistoryCards(List<OrderHistoryEntity> orders) {
    if (orders.isEmpty) {
      return const NoOrderHistoryCard();
    }
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          order: order,
          onOrderCardTap: () {
            context.pushNamed(
              AppRouterConstants.orderHistoryDetailsRouteName,
              pathParameters: {"orderId": order.id},
            );
          },
        );
      },
    );
  }
}

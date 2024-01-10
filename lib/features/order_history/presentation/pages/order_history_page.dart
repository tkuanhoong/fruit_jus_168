import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';
import 'package:fruit_jus_168/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:fruit_jus_168/features/order_history/presentation/widgets/no_order_histroy_card.dart';
import 'package:fruit_jus_168/features/order_history/presentation/widgets/order_card.dart';

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
        leading: const BackButton(),
        title: const Text('Order History'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrderHistoryError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is OrderHistoryLoaded) {
              if (state.orders.isEmpty) {
                return const NoOrderHistoryCard();
              }
              return Column(
                children: _buildOrderHistoryCards(state
                    .orders), // Replace 5 with the quantity of order's history
              );
              return Text(state.orders.toString());
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  List<Widget> _buildOrderHistoryCards(List<OrderHistoryEntity> orders) {
    List<Widget> cards = [
      ...orders.map(
        (order) => OrderCard(order: order),
      )
    ];
    return cards;
  }
}

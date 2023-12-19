

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';


class CartRepository {
  Future<void> showDeleteConfirmationDialog(BuildContext context, Product item) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('REMOVE ITEM'),
          content: const Text('Are you sure you want to remove this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Dispatch the ConfirmDeleteProduct event
                context.read<CartBloc>().add(ConfirmDeleteProduct(item));
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
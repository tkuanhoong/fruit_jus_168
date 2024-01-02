import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/address/pickup_address_constant.dart';
import 'package:fruit_jus_168/config/enum/direction.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/fulfillment_card.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:go_router/go_router.dart';

displayDeliveryPickUpDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsPadding: const EdgeInsets.only(
        bottom: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      actionsOverflowButtonSpacing: 10,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsAlignment: MainAxisAlignment.center,
      title: const Text(
        "How would you like to get your order?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: FullfillmentCard(
            text: "SELF\nPICKUP",
            imagePath: "assets/images/delivery.png",
            direction: Direction.horizontal,
            onTap: () {
              Navigator.of(context).pop();
              displayPickupLocationDialog(context);
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: FullfillmentCard(
            text: "DELIVERY",
            imagePath: "assets/images/delivery.png",
            direction: Direction.horizontal,
            onTap: () {
              Navigator.of(context).pop();
              context.pushNamed(AppRouterConstants.addressRouteName);
            },
          ),
        ),
      ],
    ),
  );
}

displayPickupLocationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 50,
        ),
        title: const Text(
          'Your Pickup Location',
        ),
        content: const Text(
          pickupAddress,
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<CartBloc>().add(
                      const FullfillmentChange(
                          address: pickupAddress, deliveryMethod: "pickup"),
                    );
                GoRouter.of(context).goNamed(AppRouterConstants.menuRouteName);
              },
              child: const Text('Confirm'))
        ],
      );
    },
  );
}

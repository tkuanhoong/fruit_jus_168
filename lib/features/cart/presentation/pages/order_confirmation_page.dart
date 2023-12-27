import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';
import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/voucher_bloc.dart';
import 'package:fruit_jus_168/features/cart/presentation/widgets/cart_item.dart';
import 'package:fruit_jus_168/features/cart/presentation/widgets/divider_text.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final remarkController = TextEditingController();
  final voucherCodeController = TextEditingController();
  late int itemQuantity;
  late int? deliveryFee;
  late int amount;
  late int subtotal;
  late int grandTotal;
  Map<String, dynamic>? paymentIntent;
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  void dispose() {
    remarkController.dispose();
    voucherCodeController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      int amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount.toString(),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(grandTotal, 'MYR');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        billingDetailsCollectionConfiguration:
            const BillingDetailsCollectionConfiguration(
                address: AddressCollectionMode.never),
        paymentIntentClientSecret:
            paymentIntent!['client_secret'], //Gotten from payment intent
        style: ThemeMode.light,
        merchantDisplayName: 'Fruit Jus 168',
      ));

      //STEP 3: Display Payment sheet
      _displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  void _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        paymentIntent = null;
        //Go to payment success page
        context.read<CartBloc>().add(ClearCart());
        context.read<VoucherBloc>().add(ResetVoucherState());
        voucherCodeController.clear();
        // context.go(AppRouterConstants.paymentSuccessRouteName);
      });
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        return;
      } else if (e.error.code == FailureCode.Failed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Payment Failed. Please try again later.'),
            content: Text('${e.error.message}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (e.error.code == FailureCode.Timeout) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Payment Timeout. Please try again later.'),
            content: Text('${e.error.message}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Unknown error occured. Please try again later.'),
          content: Text('$e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  _buildOrderSection() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CartLoaded) {
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
                      queryParameters: {
                        'quantity': "${item.quantity}",
                        'preference': "${item.preference}"
                      },
                      extra: item, // Ensure item is of type Product
                    ),
                    onDeletePressed: () async {
                      await sl<CartRepository>().showDeleteConfirmationDialog(
                          context, state.cart!.items.indexOf(item));
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
    itemQuantity = context.watch<CartBloc>().state.cart!.totalItemsQuantity;
    deliveryFee = context.watch<CartBloc>().state.cart!.deliveryFee;
    amount = context.watch<CartBloc>().state.cart!.totalPrice;
    subtotal = context.watch<CartBloc>().state.cart!.subTotal;
    grandTotal = context.watch<CartBloc>().state.cart!.grandTotal;
    return BlocListener<VoucherBloc, VoucherState>(
      listener: (context, state) {
        if (state is VoucherLoaded) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Voucher Applied'),
                    content:
                        const Text('Voucher has been applied successfully!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
          context.read<CartBloc>().add(
                VoucherChange(voucher: state.voucher),
              );
        }
        if (state is VoucherRemoved) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Voucher Removed'),
                    content:
                        const Text('Voucher has been removed successfully!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
          context.read<CartBloc>().add(
                const VoucherDelete(voucher: null),
              );
        }
        if (state is VoucherError) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(state.message.replaceAll("Exception: ", '')),
                    content: const Text('Please check and try again.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
          // reset voucher state
          context.read<VoucherBloc>().add(ResetVoucherState());
        }
      },
      child: Scaffold(
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
                Text("${context.watch<CartBloc>().state.cart!.address}"),
                const SizedBox(height: 16),
                const DividerText(
                  title: 'Your Order',
                ),
                _buildOrderSection(),
                const SizedBox(height: 16),
                const DividerText(
                  title: 'Special Remarks',
                ),
                TextField(
                  controller: remarkController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your special remarks here',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const DividerText(
                  title: 'Vouchers',
                ),
                BlocBuilder<VoucherBloc, VoucherState>(
                  builder: (context, state) {
                    if (state is VoucherLoaded && state.voucher != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextField(
                              readOnly: true,
                              controller: voucherCodeController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your voucher code here',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<VoucherBloc>()
                                    .add(RemoveVoucher());
                                voucherCodeController.clear();
                              },
                              child: const Text("Remove"),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextField(
                              readOnly: false,
                              controller: voucherCodeController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your voucher code here',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                if (voucherCodeController.text.isEmpty) return;
                                context.read<VoucherBloc>().add(
                                      ApplyVoucher(
                                        voucherCode: voucherCodeController.text,
                                        itemQuantity: itemQuantity,
                                      ),
                                    );
                              },
                              child: const Text("Apply"),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                const DividerText(
                  title: 'Payment Details',
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Amount'),
                        Text(
                            'RM ${PriceConverter.fromInt(context.watch<CartBloc>().state.cart!.totalPrice)}'),
                      ],
                    ),
                    BlocBuilder<VoucherBloc, VoucherState>(
                      builder: (context, state) {
                        if (state is VoucherLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Voucher (${state.voucher!.code})'),
                              Text(
                                  '- RM ${PriceConverter.fromInt(((state.voucher!.discount) * amount).toInt())}'),
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Voucher'),
                              Text(
                                  '- RM ${PriceConverter.fromInt((0 * amount).toInt())}'),
                            ],
                          );
                        }
                      },
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * 0.7,
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        Text('RM ${PriceConverter.fromInt(subtotal)}'),
                      ],
                    ),
                    if (deliveryFee != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Delivery Fee'),
                          Text('RM ${PriceConverter.fromInt(deliveryFee!)}'),
                        ],
                      ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * 0.7,
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Grand Total',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'RM ${PriceConverter.fromInt(grandTotal)}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
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
                      '$itemQuantity items',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'RM ${PriceConverter.fromInt(grandTotal)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () async {
                  if (itemQuantity == 0) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Your cart is empty'),
                      ),
                    );
                  } else {
                    await makePayment();
                  }
                },
                child: const Text('Order Now'),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}

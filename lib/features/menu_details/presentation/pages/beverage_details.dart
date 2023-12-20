import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruit_jus_168/features/menu_details/presentation/widgets/beverage_description.dart';
import 'package:fruit_jus_168/features/menu_details/presentation/widgets/beverage_item.dart';
import 'package:go_router/go_router.dart';

class BeverageDetailsPage extends StatefulWidget {
  const BeverageDetailsPage(
      {super.key,
      required this.beverage,
      required this.isEdit,
      this.quantity,
      this.preference});
  final Product beverage;
  final int? quantity;
  final String? preference;
  final bool isEdit;

  @override
  State<BeverageDetailsPage> createState() => _BeverageDetailsPageState();
}

class _BeverageDetailsPageState extends State<BeverageDetailsPage> {
  bool showFullDescription = false;
  late String selectedIceLevel = widget.preference ?? 'Normal Ice';
  late int itemCount = widget.quantity ?? 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Beverage Details",
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            bottom: 10,
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(104, 223, 223, 223),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxHeight: 200, maxWidth: 200),
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const Center(
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Color.fromARGB(255, 81, 81, 81),
                                ),
                              ),
                              imageUrl: "${widget.beverage.imageUrl}",
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.beverage.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BeverageDescription(
                          desc: widget.beverage.description!,
                          showFullDescription: showFullDescription),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showFullDescription = !showFullDescription;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 3,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Text(
                            showFullDescription ? "Read Less" : "Read More",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      BeverageItem(
                        name: widget.beverage.name!,
                        itemCount: itemCount,
                        selectedIceLevel: selectedIceLevel,
                        onIceChanged: (value) {
                          setState(() {
                            selectedIceLevel = value ?? 'Normal Ice';
                          });
                        },
                        onDecrease: () {
                          setState(() {
                            if (itemCount > 1) {
                              itemCount--;
                            }
                          });
                        },
                        onIncrease: () {
                          setState(() {
                            itemCount++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.beverage.name} | $selectedIceLevel",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'RM ${PriceConverter.fromInt(widget.beverage.price! * itemCount)}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.green,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (itemCount > 1 ||
                                    widget.isEdit && itemCount > 0) {
                                  itemCount--;
                                }
                              });
                            },
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        itemCount.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Material(
                          color: Colors.green,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                itemCount++;
                              });
                            },
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!widget.isEdit) // Only show if not in edit mode
              ElevatedButton(
                onPressed: () {
                  // Implement Order Now logic
                  context.read<CartBloc>().add(
                        AddProduct(
                          product: widget.beverage,
                          quantity: itemCount,
                          preference: selectedIceLevel,
                        ),
                      );
                  context.pushReplacementNamed(
                      AppRouterConstants.orderConfirmationRouteName);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: Colors.green, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fixedSize: const Size(130, 20),
                ),
                child: const Text('Order Now'),
              ),
            if (!widget.isEdit) // Only show if not in edit mode
              ElevatedButton(
                onPressed: () {
                  // Implement Add to Cart logic
                  context.read<CartBloc>().add(
                        AddProduct(
                          product: widget.beverage,
                          quantity: itemCount,
                          preference: selectedIceLevel,
                        ),
                      );
                  context.goNamed(AppRouterConstants.menuRouteName);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: Colors.green, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fixedSize: const Size(130, 20),
                ),
                child: const Text('Add to Cart'),
              ),
            if (widget.isEdit) // Only show if in edit mode
              ElevatedButton(
                onPressed: () async {
                  final itemIndex = context
                      .read<CartBloc>()
                      .state
                      .cart!
                      .items
                      .indexWhere((element) => element == widget.beverage);
                  if (itemCount != 0) {
                    context.read<CartBloc>().add(
                          UpdateProduct(
                            cartIndex: itemIndex,
                            quantity: itemCount,
                            preference: selectedIceLevel,
                          ),
                        );
                  } else {
                    await sl<CartRepository>()
                        .showDeleteConfirmationDialog(context, itemIndex);
                  }
                  if (context.mounted) {
                    context.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: Colors.green, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fixedSize: const Size(300, 20),
                ),
                child: Text(itemCount != 0 ? 'Update' : 'Remove'),
              ),
          ],
        ),
      ),
    );
  }
}

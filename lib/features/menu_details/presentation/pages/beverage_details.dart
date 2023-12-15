import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruit_jus_168/features/menu_details/data/datasource/beverage_datasource.dart';
import 'package:fruit_jus_168/features/menu_details/data/repository/beverage_repository_impl.dart';
import 'package:fruit_jus_168/features/menu_details/presentation/widgets/beverage_description.dart';
import 'package:fruit_jus_168/features/menu_details/presentation/widgets/beverage_item.dart';
import 'package:fruit_jus_168/features/menu_details/domain/entities/beverage.dart';
import 'package:fruit_jus_168/features/menu_details/presentation/pages/utils/beverage_utils.dart';
import 'package:go_router/go_router.dart';

class BeverageDetailsPage extends StatefulWidget {
  const BeverageDetailsPage({super.key, required this.beverage, this.isEdit});
  final Product beverage;
  final bool? isEdit;

  @override
  State<BeverageDetailsPage> createState() => _BeverageDetailsPageState();
}

class _BeverageDetailsPageState extends State<BeverageDetailsPage> {
  // final BeverageRepositoryImpl _beverageRepository =
  //     BeverageRepositoryImpl(FirestoreService());
  // List<BeverageEntity> products = [];
  bool showFullDescription = false;
  String selectedIceLevel = 'Normal Ice';
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    // fetchProducts();
  }

  // Future<void> fetchProducts() async {
  //   try {
  //     // Call the getProducts method from BeverageRepository
  //     List<BeverageEntity> fetchedProducts =
  //         await _beverageRepository.getProducts();

  //     setState(() {
  //       products = fetchedProducts;
  //     });
  //   } catch (e) {
  //     // Handle errors
  //     throw Exception('Errors fetching products: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Beverage Details',
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
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 80,
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
                          style: TextStyle(
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
                                if (itemCount > 1) {
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
            ElevatedButton(
              onPressed: () {
                // Implement Order Now logic
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
            ElevatedButton(
              onPressed: () {
                // Implement Add to Cart logic
                context.read<CartBloc>().add(
                      AddProduct(
                          product: widget.beverage,
                          quantity: itemCount,
                          preference: selectedIceLevel),
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
          ],
        ),
      ),
    );
  }
}

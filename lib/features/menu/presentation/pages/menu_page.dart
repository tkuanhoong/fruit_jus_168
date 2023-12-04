import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ScrollController _scrollController = ScrollController();
  bool isScrollingDown = false;

  void initState() {
    super.initState(); // Adjust the length according to your categories
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      isScrollingDown = _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse
          ? false
          : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth;
    //return sliverappbar
    return Scaffold(
      appBar: isScrollingDown
          ? AppBar(
              backgroundColor: Colors.grey,
              title: Text('1st app bar'),
            )
          : AppBar(
              backgroundColor: Colors.grey,
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        onTap: () => context
                            .pushNamed(AppRouterConstants.searchRouteName),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Search',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: Column(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.red),
            child: Row(children: [
              Flexible(
                flex: 1,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.amber,
                      child: const Text('data'),
                    );
                  },
                ),
              ),
              Flexible(
                flex: 4,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRouterConstants.beverageDetailsRouteName,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            color: Colors.amber,
                            child: const Text('data'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

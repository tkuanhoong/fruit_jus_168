import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/search/presentation/bloc/search_bloc.dart';
import 'package:fruit_jus_168/features/search/presentation/widgets/typing_search_bar.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _debounce;
  List _allResult = [];
  bool _searching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String queryText) {
    setState(() {
      _searching = true;
    });
    // decounce to slow down the request
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      BlocProvider.of<SearchBloc>(context).add(SearchRequested(queryText));
      setState(() {
        _searching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypingSearchBar(
                  onSearchChanged: _onSearchChanged,
                  searching: _searching,
                ),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is SearchLoaded) {
                    _allResult = state.searchResult;
                    if (_allResult.isEmpty) {
                      return const Expanded(
                          child: Center(child: Text("No Result")));
                    }
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                        ),
                        itemCount: _allResult.length,
                        itemBuilder: (context, index) {
                          final product = _allResult[index];
                          return Column(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouterConstants
                                          .beverageDetailsRouteName,
                                      extra: product,
                                      pathParameters: {"isEdit": "false"},
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Positioned(
                                        bottom: 10,
                                        child: Container(
                                          height: 130,
                                          width: 130,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                104, 223, 223, 223),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                        height: 0.5,
                                                        width: 15,
                                                        child:
                                                            LinearProgressIndicator(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          color: Color.fromARGB(
                                                              255, 81, 81, 81),
                                                        )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              imageUrl: "${product.imageUrl}",
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${product.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  fontFamily: 'Mulish',
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'RM ${PriceConverter.fromInt(product.price)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  fontFamily: 'Mulish',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

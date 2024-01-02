import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/core/utility/dialog_display.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:fruit_jus_168/features/menu/presentation/widgets/highlighted_category.dart';
import 'package:fruit_jus_168/features/menu/presentation/widgets/menu_loading.dart';
import 'package:fruit_jus_168/features/menu/presentation/widgets/not_highlighted_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool isScrollingDown = true;
  final Map<String, GlobalKey> _categoryKeys = {};
  final double marginForSection = 30;
  final double marginForTop = 10;
  final double triggerTopMargin = 10;
  late GlobalKey highlightedKey = _categoryKeys.entries.first.value;
  late List<double> positions = _categoryKeys
      .map((key, value) => MapEntry(
          key,
          value.currentContext!
                  .findRenderObject()!
                  .getTransformTo(null)
                  .getTranslation()
                  .y -
              kToolbarHeight -
              marginForSection -
              marginForTop -
              triggerTopMargin))
      .values
      .toList();

  @override
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

      for (var i = 0; i < positions.length; i++) {
        if (_scrollController.offset >= positions[i]) {
          setState(
              () => highlightedKey = _categoryKeys.entries.elementAt(i).value);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isScrollingDown
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 209, 231, 207),
              title: GestureDetector(
                onTap: () {
                  displayDeliveryPickUpDialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: AppBar().preferredSize.height * 0.65,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    children: [
                      Flexible(
                          flex: 2,
                          child: Icon(
                            Icons.share_location_outlined,
                            color: Color(0XFF20941C),
                          )),
                      Flexible(
                        flex: 1,
                        child: SizedBox(width: 20),
                      ),
                      Flexible(
                        flex: 7,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            'Change Your Delivery Option Here',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : AppBar(
              backgroundColor: const Color.fromARGB(255, 209, 231, 207),
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
                            color: Color(0XFF20941C),
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
      body: BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
        if (state is MenuLoading) {
          return const MenuLoadingIndicator();
        }
        if (state is MenuError) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is MenuLoaded) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsetsDirectional.only(top: marginForTop),
                  child: Row(children: [
                    Flexible(
                      flex: 1,
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: state.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final category = state.categories[index];
                            return GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(positions[index],
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.slowMiddle);
                                highlightedKey = _getCategoryKey(category.name);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 1,
                                ),
                                padding: const EdgeInsets.only(top: 10),
                                decoration: highlightedKey ==
                                        _getCategoryKey(category.name)
                                    ? highlighted_category()
                                    : not_highlighted_category(),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(category.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 70,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        child: Text(category.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          }),
                    ),
                    Flexible(
                      flex: 4,
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: state.categories.expand((category) {
                          return _menuBuilder(
                            category.name,
                            category.products,
                            categoryKey: _getCategoryKey(category.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          );
        }
        return Container();
      }),
      floatingActionButton: Stack(
        children: [
          Positioned(
            child: FloatingActionButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  AppRouterConstants.orderConfirmationRouteName,
                );
              },
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.shopping_cart),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: context.watch<CartBloc>().state.cart!.totalItemsQuantity != 0
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Colors.red),
                    child: Center(
                      child: Text(
                        context
                            .watch<CartBloc>()
                            .state
                            .cart!
                            .totalItemsQuantity
                            .toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  List<Widget> _menuBuilder(
    String category,
    List<Product> products, {
    required GlobalKey categoryKey,
  }) {
    return <Widget>[
      SliverToBoxAdapter(
        key: categoryKey,
        child: Container(
          margin: EdgeInsets.only(top: marginForSection),
          child: Text(
            '|  $category',
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'Mulish',
                color: Color.fromARGB(255, 19, 88, 17)),
          ),
        ),
      ),
      SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          const StretchingOverscrollIndicator(
              axisDirection: AxisDirection.down);
          final product = products[index];
          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRouterConstants.beverageDetailsRouteName,
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
                            color: Color.fromARGB(104, 223, 223, 223),
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
                              placeholder: (context, url) => const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        height: 0.5,
                                        width: 15,
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey,
                                          color:
                                              Color.fromARGB(255, 81, 81, 81),
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
              Container(
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
              Container(
                height: 5,
              ),
              Text(
                'RM ${PriceConverter.fromInt(product.price!)}',
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    fontFamily: 'Mulish'),
              ),
            ],
          );
        },
      ),
    ];
  }

  GlobalKey _getCategoryKey(String categoryName) {
    if (_categoryKeys.containsKey(categoryName)) {
      return _categoryKeys[categoryName]!;
    } else {
      GlobalKey categoryKey = GlobalKey();
      _categoryKeys[categoryName] = categoryKey;
      return categoryKey;
    }
  }
}

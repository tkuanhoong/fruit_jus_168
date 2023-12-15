import 'package:fruit_jus_168/features/menu/presentation/widgets/highlighted_category.dart';
import 'package:fruit_jus_168/features/menu/presentation/widgets/menu_loading.dart';
import 'package:fruit_jus_168/features/menu/presentation/widgets/not_highlighted_category.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/menu/data/datasources/menu_service.dart';
import 'package:fruit_jus_168/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:fruit_jus_168/features/menu/domain/usecases/get_all_category.dart';
import 'package:fruit_jus_168/features/menu/domain/usecases/get_category_product.dart';
import 'package:fruit_jus_168/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:fruit_jus_168/features/menu/presentation/bloc/menu_event.dart';
import 'package:fruit_jus_168/features/menu/presentation/bloc/menu_state.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool isScrollingDown = false;
  late MenuBloc _menuBloc;
  final Map<String, GlobalKey> _categoryKeys = {};
  int highlighted = 0;

  @override
  void initState() {
    super.initState(); // Adjust the length according to your categories
    _scrollController.addListener(_scrollListener);
    _menuBloc = MenuBloc(
      GetCategoryProducts(
          MenuRepositoryImpl(MenuService(FirebaseFirestore.instance))),
      GetAllCategories(
          MenuRepositoryImpl(MenuService(FirebaseFirestore.instance))),
    );
    _menuBloc.add(FetchAllCategories());
  }

  void _scrollListener() {
    setState(() {
      isScrollingDown = _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse
          ? false
          : true;
    });
    // log('scrolls' + _scrollController.offset.toString());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _menuBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuBloc>.value(
      value: _menuBloc,
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return menu_loading(context);
          } else if (state is MenuLoaded) {
            return Scaffold(
                appBar: isScrollingDown
                    ? AppBar(
                        backgroundColor:
                            const Color.fromARGB(255, 209, 231, 207),
                        title: Container(
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
                                    'Your Address Here',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : AppBar(
                        backgroundColor:
                            const Color.fromARGB(255, 209, 231, 207),
                        title: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  readOnly: true,
                                  // onTap: () => context
                                  //     .pushNamed(AppRouterConstants.searchRouteName),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color(0XFF20941C),
                                    ),
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
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
                      margin: const EdgeInsetsDirectional.only(top: 10),
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
                                    _scrollController.animateTo(
                                      _getCategoryKey(category.name)
                                          .currentContext!
                                          .findRenderObject()!
                                          .getTransformTo(null)
                                          .getTranslation()
                                          .y,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.slowMiddle,
                                    );
                                    highlighted = index;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 1,
                                    ),
                                    padding: const EdgeInsets.only(top: 10),
                                    decoration: highlighted == index
                                        ? highlighted_category()
                                        : not_highlighted_category(),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  category.imageUrl),
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
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 10)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
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
                ]));
          } else {
            return const Text('Error');
          }
        },
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
            height: 30,
          )),
      SliverToBoxAdapter(
        child: Text(
          '|  $category' /*+ categoryKey.toString()*/,
          style: GoogleFonts.mulish(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color.fromARGB(255, 19, 88, 17)),
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
          double productprice = double.parse(product.price.toString()) / 100;
          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(product.name.toString()),
                        duration: const Duration(milliseconds: 50),
                      ),
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
                            child: Image.network(product.imageUrl.toString())),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 15,
              ),
              Text(product.name.toString(),
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w700, fontSize: 14)),
              Container(
                height: 5,
              ),
              Text('RM ${productprice.toStringAsFixed(2)}',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w700, fontSize: 12)),
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

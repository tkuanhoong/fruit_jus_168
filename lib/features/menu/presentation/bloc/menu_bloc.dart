import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/menu/domain/usecases/get_all_category.dart';
import 'package:fruit_jus_168/features/menu/domain/usecases/get_category_product.dart';
import 'package:fruit_jus_168/features/menu/presentation/bloc/menu_event.dart';
import 'package:fruit_jus_168/features/menu/presentation/bloc/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetCategoryProducts getCategoryProducts;
  final GetAllCategories getAllCategories;

  MenuBloc(this.getCategoryProducts, this.getAllCategories)
      : super(MenuInitial()) {
    on<FetchCategoryProducts>((event, emit) async {
      emit(MenuLoading());
      try {
        final products = await getCategoryProducts.execute(event.category);
        emit(CategoryProductsLoaded(products));
      } catch (e) {
        emit(MenuError(message: e.toString()));
      }
    });

    on<FetchAllCategories>((event, emit) async {
      emit(MenuLoading());
      try {
        final categories = await getAllCategories.execute();
        emit(MenuLoaded(categories));
      } catch (e) {
        emit(MenuError(message: e.toString()));
      }
    });
  }
}

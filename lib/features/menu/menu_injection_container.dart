import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/features/menu/data/datasources/menu_api_service.dart';
import 'package:fruit_jus_168/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:fruit_jus_168/features/menu/domain/usecases/get_all_category.dart';
import 'package:fruit_jus_168/features/menu/domain/usecases/get_category_product.dart';

import 'domain/repositories/menu_repository.dart';
import 'presentation/bloc/menu_bloc.dart';

Future<void> menuInjectionContainer() async {
  // Dependencies
  sl.registerSingleton<MenuApiService>(sl());
  sl.registerSingleton<MenuRepository>(MenuRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<GetCategoryProducts>(GetCategoryProducts(sl()));
  sl.registerSingleton<GetAllCategories>(GetAllCategories(sl()));
  
  // Blocs
  sl.registerFactory<MenuBloc>(() => MenuBloc(sl(), sl()));
}

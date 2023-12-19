import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/features/search/data/datasources/search_api_service.dart';
import 'package:fruit_jus_168/features/search/data/repositories/seach_repository_impl.dart';
import 'package:fruit_jus_168/features/search/domain/repositories/search_repository.dart';
import 'package:fruit_jus_168/features/search/domain/usecases/search_product.dart';
import 'package:fruit_jus_168/features/search/presentation/bloc/search_bloc.dart';

Future<void> searchInjectionContainer() async {
  // Dependencies
  sl.registerSingleton<SearchApiService>(SearchApiService(sl()));
  sl.registerSingleton<SearchRepository>(SearchRepositoryImpl(sl()));

  // Usecase
  sl.registerSingleton(SearchProductUseCase(sl()));

  // Blocs
  sl.registerFactory<SearchBloc>(() => SearchBloc(sl()));
}

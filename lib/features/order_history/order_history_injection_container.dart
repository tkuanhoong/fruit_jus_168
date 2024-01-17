import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/features/order_history/data/repositories/order_history_impl.dart';
import 'package:fruit_jus_168/features/order_history/domain/repositories/order_history_repository.dart';
import 'package:fruit_jus_168/features/order_history/domain/usecases/get_order_list.dart';
import 'package:fruit_jus_168/features/order_history/presentation/bloc/order_history_bloc.dart';

import 'data/datasources/order_history_api_service.dart';

Future<void> orderHistoryInjectionContainer() async {
  // Dependencies
  sl.registerSingleton<OrderHistoryApiService>(
      OrderHistoryApiService(sl(), sl()));
  sl.registerSingleton<OrderHistoryRepository>(
      OrderHistoryRepositoryImpl(sl()));

  // Usecase
  sl.registerSingleton(GetOrderListUseCase(sl()));

  // Blocs
  sl.registerFactory<OrderHistoryBloc>(() => OrderHistoryBloc(sl()));
}

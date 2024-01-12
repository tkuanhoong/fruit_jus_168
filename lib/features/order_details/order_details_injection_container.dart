import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/features/order_details/data/datasources/order_details_api_service.dart';
import 'package:fruit_jus_168/features/order_details/data/repositories/order_details_repository_impl.dart';
import 'package:fruit_jus_168/features/order_details/domain/repositories/order_details_repository.dart';
import 'package:fruit_jus_168/features/order_details/domain/usecases/get_order_details.dart';
import 'package:fruit_jus_168/features/order_details/presentation/bloc/order_details_bloc.dart';

Future<void> orderDetailsInjectionContainer() async {
  // Dependencies
  sl.registerSingleton<OrderDetailsApiService>(
      OrderDetailsApiService(sl(), sl()));
  sl.registerSingleton<OrderDetailsRepository>(
      OrderDetailsRepositoryImpl(sl()));

  // Usecase
  sl.registerSingleton(GetOrderDetailsUseCase(sl()));

  // Blocs
  sl.registerFactory<OrderDetailsBloc>(() => OrderDetailsBloc(sl()));
}
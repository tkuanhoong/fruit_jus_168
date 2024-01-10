import 'package:fruit_jus_168/core/data/datasources/order_api_service.dart';
import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/features/cart/data/datasources/voucher_api_service.dart';
import 'package:fruit_jus_168/features/cart/data/repositories/order_repository_impl.dart';
import 'package:fruit_jus_168/features/cart/data/repositories/voucher_reporsitory_impl.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/order_repository.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/voucher_repository.dart';
import 'package:fruit_jus_168/features/cart/domain/usecases/get_voucher.dart';
import 'package:fruit_jus_168/features/cart/domain/usecases/make_order.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/voucher_bloc.dart';

Future<void> cartInjectionContainer() async {
  // Dependencies
  sl.registerSingleton<VoucherApiService>(VoucherApiService(sl(), sl()));
  sl.registerSingleton<VoucherRepository>(VoucherRepositoryImpl(sl()));
  sl.registerSingleton<CartRepository>(CartRepository());

  sl.registerSingleton<OrderApiService>(OrderApiService(sl(), sl()));
  sl.registerSingleton<OrderRepository>(OrderRepositoryImpl(sl()));

  // Usecase
  sl.registerSingleton(GetVoucherUseCase(sl()));
  sl.registerSingleton(MakeOrderUseCase(sl()));

  // Blocs
  sl.registerFactory<CartBloc>(() => CartBloc(sl()));
  sl.registerFactory<VoucherBloc>(() => VoucherBloc(sl()));
}

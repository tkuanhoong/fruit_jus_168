import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';

Future<void> cartInjectionContainer() async {
  sl.registerSingleton<CartRepository>(CartRepository());
  // Blocs
  sl.registerFactory<CartBloc>(() => CartBloc());
}

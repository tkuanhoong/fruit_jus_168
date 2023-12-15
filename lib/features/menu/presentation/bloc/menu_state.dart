import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/menu/domain/entities/category.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Category> categories;

  MenuLoaded(this.categories);
}

class CategoryProductsLoaded extends MenuState {
  final List<Product> products;

  CategoryProductsLoaded(this.products);
}

class MenuError extends MenuState {
  final String message;

  MenuError({required this.message});
}

part of 'menu_bloc.dart';

abstract class MenuEvent {}

class FetchCategoryProducts extends MenuEvent {
  final String category;

  FetchCategoryProducts({required this.category});
}

class FetchAllCategories extends MenuEvent {}

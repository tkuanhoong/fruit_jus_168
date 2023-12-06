import 'package:fruit_jus_168/features/search/domain/entities/search_item.dart';

abstract class SearchRepository {
  Stream<List<SearchItemEntity>> searchProduct(String query);
}

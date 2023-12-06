import 'package:fruit_jus_168/features/search/data/datasources/search_api_service.dart';
import 'package:fruit_jus_168/features/search/data/models/search_item_model.dart';
import 'package:fruit_jus_168/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService _searchApiService;

  SearchRepositoryImpl(this._searchApiService);

  @override
  Stream<List<SearchItemModel>> searchProduct(String query) =>
      _searchApiService.searchProduct(query);
}

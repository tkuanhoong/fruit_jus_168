import 'package:fruit_jus_168/core/usecases/stream_usecase.dart';
import 'package:fruit_jus_168/features/search/domain/entities/search_item.dart';
import 'package:fruit_jus_168/features/search/domain/repositories/search_repository.dart';

class SearchProductUseCase
    implements StreamUseCase<List<SearchItemEntity>, String> {
  final SearchRepository _searchRepository;
  SearchProductUseCase(this._searchRepository);

  @override
  Stream<List<SearchItemEntity>> call({String? params}) =>
      _searchRepository.searchProduct(params!);
}

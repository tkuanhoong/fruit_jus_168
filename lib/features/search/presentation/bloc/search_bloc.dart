import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/search/domain/usecases/search_product.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductUseCase searchProductUseCase;
  SearchBloc(this.searchProductUseCase) : super(SearchLoading()) {
    on<SearchRequested>(_onSearchRequested, transformer: restartable());
  }
  _onSearchRequested(SearchRequested event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final products = searchProductUseCase(params: event.query);
      await emit.forEach(products, onData: (data) => SearchLoaded(data));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

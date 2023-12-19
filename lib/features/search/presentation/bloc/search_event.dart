part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRequested extends SearchEvent {
  final String query;
  const SearchRequested(this.query);
  @override
  List<Object> get props => [query];
}

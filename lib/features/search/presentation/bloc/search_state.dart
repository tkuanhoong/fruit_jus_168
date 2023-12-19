part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List searchResult;

  const SearchLoaded(this.searchResult);

  @override
  List<Object> get props => [searchResult];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
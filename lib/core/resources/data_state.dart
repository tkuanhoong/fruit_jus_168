import 'package:firebase_core/firebase_core.dart';

abstract class DataState<T> {
  final T? data;
  final FirebaseException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(FirebaseException error) : super(error: error);
}

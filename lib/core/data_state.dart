import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

class Success<T> extends DataState<T> {
  const Success(T data) : super(data: data);
}

class Failed<T> extends DataState<T> {
  const Failed(DioException error) : super(error: error);
}

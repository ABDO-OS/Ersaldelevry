import 'package:equatable/equatable.dart';
import '../errors/failures.dart';

abstract class Result<T> extends Equatable {
  const Result();

  @override
  List<Object?> get props => [];
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  List<Object?> get props => [data];
}

class Error<T> extends Result<T> {
  final Failure failure;

  const Error(this.failure);

  @override
  List<Object?> get props => [failure];
}

extension ResultExtension<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isError => this is Error<T>;

  T? get data => isSuccess ? (this as Success<T>).data : null;
  Failure? get failure => isError ? (this as Error<T>).failure : null;

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    if (isSuccess) {
      return success((this as Success<T>).data);
    } else {
      return error((this as Error<T>).failure);
    }
  }
}

part of '../core.dart';

abstract class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => this is Success<T> ? (this as Success<T>).value : null;
  AppError? get error => this is Failure<T> ? (this as Failure<T>).error : null;
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  @override
  final AppError error;
  const Failure(this.error);
}

extension ResultX<T> on Result<T> {
  Result<R> map<R>(R Function(T) f) {
    if (this is Success<T>) {
      return Success(f((this as Success<T>).value));
    } else {
      return Failure((this as Failure<T>).error);
    }
  }

  R fold<R>(R Function(AppError error) onFailure, R Function(T value) onSuccess) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).value);
    } else {
      return onFailure((this as Failure<T>).error);
    }
  }

  void when({
    required Function(T value) success,
    required Function(AppError error) failure,
  }) {
    if (this is Success<T>) {
      success((this as Success<T>).value);
    } else {
      failure((this as Failure<T>).error);
    }
  }
}

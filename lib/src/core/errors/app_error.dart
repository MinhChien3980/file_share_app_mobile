part of '../core.dart';

class AppError implements Exception {
  final String? code;
  final String message;
  final String? title;
  final StackTrace? stackTrace;
  final List<FieldError>? fieldErrors;

  AppError(this.message,
      {this.title, this.stackTrace, this.code, this.fieldErrors});

  @override
  String toString() {
    return 'AppError: $message, code: $code, stackTrace: $stackTrace';
  }

  factory AppError.fromDioException(DioException exception) {
    String message = 'An unknown error occurred';
    String? code;
    String? title;
    List<FieldError>? fieldErrors;
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        code = ErrorCode.timeout;
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        code = ErrorCode.timeout;
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        code = ErrorCode.timeout;
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        code = ErrorCode.unknown;
        break;
      case DioExceptionType.badResponse:
        final response = exception.response;
        if (response != null) {
          code = ErrorCode.server;
          final data = response.data;
          if (data is Map<String, dynamic>) {
            message = data['message'] ?? 'Bad response';
            title = data['title'];
            if (data['fieldErrors'] != null) {
              final fieldErrors = (data['fieldErrors'] as List)
                  .map((e) => FieldError(e['field'], e['message']))
                  .toList();
              return AppError(message,
                  fieldErrors: fieldErrors, code: code, title: title);
            }
          } else if (data is String) {
            message = data;
          } else {
            message = 'Bad response';
          }
        } else {
          message = 'Bad response';
          code = ErrorCode.unknown;
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        code = ErrorCode.unknown;
        break;
      case DioExceptionType.connectionError:
        message = 'Connection error';
        code = ErrorCode.network;
        break;
      case DioExceptionType.unknown:
        message = 'Unknown error';
        code = ErrorCode.unknown;
        break;
    }

    return AppError(message, stackTrace: exception.stackTrace, code: code);
  }
}

class FieldError {
  final String field;
  final String message;

  FieldError(this.field, this.message);

  @override
  String toString() {
    return 'FieldError: $field: $message';
  }
}

class ErrorCode {
  static const String network = 'network';
  static const String server = 'server';
  static const String unknown = 'unknown';
  static const String invalidInput = 'invalid_input';
  static const String unauthorized = 'unauthorized';
  static const String forbidden = 'forbidden';
  static const String notFound = 'not_found';
  static const String conflict = 'conflict';
  static const String timeout = 'timeout';
  static const String invalidToken = 'invalid_token';
  static const String googleAuth = 'google_auth';
  static const String login = 'login';
  static const String profile = 'profile';
}

part of '../core.dart';

final globalCancelToken = CancelToken();

class RestClient {
  final List<Interceptor> interceptors;

  RestClient({required this.interceptors});

  Dio _getDio({Map<String, dynamic>? newHeaders}) {
    final dio = Dio();

    dio.options = BaseOptions(
      connectTimeout: AppConfig.defaultTimeout,
      receiveTimeout: AppConfig.defaultTimeout,
      sendTimeout: AppConfig.defaultTimeout,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 500;
      },
    );
    dio.interceptors.addAll(interceptors);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final defaultHeaders = <String, dynamic>{
          'Platform': Platform.isIOS ? 'ios' : 'android',
          'App-Version': AppConfig.appVersion,
        };
        final currentToken = getIt<StorageService>().userToken;
        if (currentToken.isNotEmpty) {
          defaultHeaders['Authorization'] = 'Bearer $currentToken';
        }
        if (newHeaders != null) {
          defaultHeaders.addAll(newHeaders);
        }

        options.headers.addAll(defaultHeaders);
        handler.next(options);
      },
    ));

    return dio;
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    T Function(dynamic data)? decodeData,
  }) async {
    final url = path.startsWith('http://') || path.startsWith('https://')
        ? path
        : '${EnvConfig.baseUrl}$path';
    final response = await _getDio().get(
      url,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? globalCancelToken,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (decodeData != null) {
        return decodeData(response.data);
      }
      return response.data;
    } else {
      throw AppError(
        'Error: ${response.statusCode}',
        stackTrace: StackTrace.current,
        code: response.statusCode.toString(),
      );
    }
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    T Function(dynamic data)? decodeData,
  }) async {
    final url = path.startsWith('http://') || path.startsWith('https://')
        ? path
        : '${EnvConfig.baseUrl}$path';
    final response = await _getDio().post(
      url,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? globalCancelToken,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (decodeData != null) {
        return decodeData(response.data);
      }
      return response.data;
    } else {
      throw AppError(
        'Error: ${response.statusCode}',
        stackTrace: StackTrace.current,
        code: response.statusCode.toString(),
      );
    }
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    T Function(dynamic data)? decodeData,
  }) async {
    final url = path.startsWith('http://') || path.startsWith('https://')
        ? path
        : '${EnvConfig.baseUrl}$path';
    final response = await _getDio().put(
      url,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? globalCancelToken,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (decodeData != null) {
        return decodeData(response.data);
      }
      return response.data;
    } else {
      throw AppError(
        'Error: ${response.statusCode}',
        stackTrace: StackTrace.current,
        code: response.statusCode.toString(),
      );
    }
  }

  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    T Function(dynamic data)? decodeData,
  }) async {
    final url = path.startsWith('http://') || path.startsWith('https://')
        ? path
        : '${EnvConfig.baseUrl}$path';
    final response = await _getDio().delete(
      url,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken ?? globalCancelToken,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (decodeData != null) {
        return decodeData(response.data);
      }
      return response.data;
    } else {
      throw AppError(
        'Error: ${response.statusCode}',
        stackTrace: StackTrace.current,
        code: response.statusCode.toString(),
      );
    }
  }
}

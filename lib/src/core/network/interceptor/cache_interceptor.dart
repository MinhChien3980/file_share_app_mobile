// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../core.dart';

final _cacheKeyData = <_CacheKey, Response<dynamic>>{};

class CacheInterceptor extends Interceptor {
  final bool Function(String url, RequestOptions options) shouldCache;
  final String cacheKeyHeader;

  CacheInterceptor({
    required this.shouldCache,
    required this.cacheKeyHeader,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Check if the request is cached
    final cacheKey = _CacheKey(
      method: options.method,
      url: options.path,
    );

    if (options.headers[cacheKeyHeader] == true && _cacheKeyData.containsKey(cacheKey)) {
      // Return the cached response
      final cachedResponse = _cacheKeyData[cacheKey];
      handler.resolve(cachedResponse!);
    } else {
      super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle the response and cache it if necessary

    final cacheKey = _CacheKey(
      method: response.requestOptions.method,
      url: response.requestOptions.path,
    );

    if (shouldCache(response.requestOptions.path, response.requestOptions)) {
      _cacheKeyData[cacheKey] = response;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle errors
    super.onError(err, handler);
  }
}

class _CacheKey {
  final String method;
  final String url;

  _CacheKey({
    required this.method,
    required this.url,
  });

  @override
  bool operator ==(covariant _CacheKey other) {
    if (identical(this, other)) return true;

    return other.method == method && other.url == url;
  }

  @override
  int get hashCode => method.hashCode ^ url.hashCode;
}

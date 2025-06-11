part of '../../core.dart';

class InvalidTokenInterceptor extends Interceptor {
  final void Function() onTokenExpired;

  InvalidTokenInterceptor({required this.onTokenExpired});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      onTokenExpired();
    }
  }
}

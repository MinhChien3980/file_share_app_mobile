part of '../../auth.dart';

@lazySingleton
class AuthRepository {
  final _storage = getIt<StorageService>();
  final _restClient = getIt<RestClient>();
  final _googleSignIn = GoogleSignIn();

  Future<Result<AuthModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final authModel = await _restClient.post<AuthModel>(
        '/authenticate',
        data: {
          "username": username,
          "password": password,
        },
        decodeData: (data) {
          return AuthModel.fromJson(Map<String, dynamic>.from(data as Map));
        },
      );
      if (authModel.idToken.isEmpty) {
        return Failure(AppError(
          'Login failed',
          code: ErrorCode.login,
          title: 'Login',
        ));
      }
      await _storage.setIsLoggedIn(true);
      await _storage.setUserToken(authModel.idToken);
      return Success(authModel);
    } catch (e) {
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'Login Failed',
        code: ErrorCode.login,
        title: 'Login',
      ));
    }
  }

  Future<Result<AuthModel>> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return Failure(AppError(
          'Login failed',
          code: ErrorCode.googleAuth,
          title: 'Google Login',
        ));
      }

      final googleAuth = await googleUser.authentication;
      final ggToken = googleAuth.idToken;

      print('Google idToken: $ggToken');
      print('Google accessToken: ${googleAuth.accessToken}');
      if (ggToken == null) {
        return Failure(AppError(
          'Login failed',
          code: ErrorCode.googleAuth,
          title: 'Google Login',
        ));
      }
      final authModel = await _restClient.post<AuthModel>(
        'http://10.0.2.2:8080/api/test-auth',
        data: {'ggToken': ggToken},
        decodeData: (data) =>
            AuthModel.fromJson(Map<String, dynamic>.from(data as Map)),
      );
      print('authModel: ${authModel.toJson()}');
      await _storage.setUserToken(authModel.idToken);
      return Success(authModel);
    } catch (e, stack) {
      print('❌ loginWithGoogle error: $e');
      print('stack errorerror: $stack');
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'Login Failed',
        code: ErrorCode.googleAuth,
        title: 'Login',
      ));
    } finally {
      await _googleSignIn.signOut();
    }
  }

  Future<Result> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    throw UnimplementedError();
  }

  Future<Result> forgetPassword({
    required String email,
  }) async {
    throw UnimplementedError();
  }
}

part of '../../home.dart';

@lazySingleton
class HomeRepository {
  final _restClient = getIt<RestClient>();

  Future<Result<ProfileModel>> getUser() async {
    try {
      final response = await _restClient.get(
        '/account',
        decodeData: (data) {
          return ProfileModel.fromJson(data);
        },
      );
      return Success(response);
    } catch (e) {
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'An error occurred while fetching user data',
        stackTrace: StackTrace.current,
      ));
    }
  }
}

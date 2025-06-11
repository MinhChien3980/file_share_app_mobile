part of '../../profile.dart';

@lazySingleton
class ProfileRepository {
  final _restClient = getIt<RestClient>();

  Future<Result<ProfileModel>> getProfile() async {
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

  Future<Result<ProfileModel>> updateProfile({
    String? imageUrl,
    String? login,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? address,
    String? birthDate,
    File? imageFile,
  }) async {
    try {
      // Create FormData for multipart/form-data request
      final formData = dio.FormData();

      // Add text fields
      if (login != null) formData.fields.add(MapEntry('login', login));
      if (firstName != null) {
        formData.fields.add(MapEntry('firstName', firstName));
      }
      if (lastName != null) formData.fields.add(MapEntry('lastName', lastName));
      if (email != null) formData.fields.add(MapEntry('email', email));
      if (phone != null) formData.fields.add(MapEntry('phoneNumber', phone));
      if (address != null) formData.fields.add(MapEntry('address', address));
      if (birthDate != null) {
        formData.fields.add(MapEntry('birthDate', birthDate));
      }

      // Add file if provided
      if (imageFile != null) {
        final fileName = imageFile.path.split('/').last;
        formData.files.add(MapEntry(
          'file',
          await dio.MultipartFile.fromFile(
            imageFile.path,
            filename: fileName,
          ),
        ));
      }

      final response = await _restClient.post(
        '/account',
        data: formData,
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
        'An error occurred while updating profile',
        stackTrace: StackTrace.current,
      ));
    }
  }

  Future<Result<ProfileModel>> changePassword(
      String oldPassword, String newPassword) async {
    try {
      final response = await _restClient.post(
        '/account/change-password',
        data: {
          'currentPassword': oldPassword,
          'newPassword': newPassword,
        },
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
        'An error occurred while changing password',
        stackTrace: StackTrace.current,
      ));
    }
  }
}

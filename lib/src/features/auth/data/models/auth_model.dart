part of '../../auth.dart';

// Your code here...
class AuthModel {
  String idToken;

  AuthModel({
    required this.idToken,
  });
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      idToken: json['id_token'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id_token': idToken,
    };
  }
}

part of '../../home.dart';

class UserModel {
  int? id;
  String? login;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  bool? activated;
  String? langKey;
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  List<String>? authorities;

  UserModel({
    this.id,
    this.login,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.activated,
    this.langKey,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.authorities,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      login: json['login'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      activated: json['activated'],
      langKey: json['langKey'],
      createdBy: json['createdBy'],
      createdDate: DateTime.parse(json['createdDate']),
      lastModifiedBy: json['lastModifiedBy'],
      lastModifiedDate: DateTime.parse(json['lastModifiedDate']),
      authorities: List<String>.from(json['authorities']),
    );
  }
}

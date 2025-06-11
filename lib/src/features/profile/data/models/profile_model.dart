part of '../../profile.dart';

class ProfileModel {
  int? id;
  String? login;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? phoneNumber;
  String? address;
  String? dateOfBirth;

  ProfileModel({
    this.id,
    this.login,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.phoneNumber,
    this.address,
    this.dateOfBirth,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int?,
      login: json['login'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateOfBirth': dateOfBirth,
    };
  }
}

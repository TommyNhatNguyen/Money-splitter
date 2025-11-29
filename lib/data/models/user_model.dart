import 'package:ecommerce/core/models/base_model.dart';

class UserModel extends BaseModel {
  UserModel({
    required this.id,
    required this.username,
    required this.usernameNormalized,
    this.email,
    this.phone,
  });

  final String id;
  final String username;
  final String usernameNormalized;
  final String? email;
  final int? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      usernameNormalized: json['usernameNormalized'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'usernameNormalized': usernameNormalized,
      'email': email,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [id, username, usernameNormalized, email, phone];
}

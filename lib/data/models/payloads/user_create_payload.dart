import 'package:ecommerce/core/models/base_model.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';

class UserCreatePayload extends BaseModel {
  final String? id;
  final String username;
  final String usernameNormalized;
  final String? phone;
  final String? email;
  final AuthRegisterPayload authPayload;

  UserCreatePayload({
    this.id,
    required this.username,
    required this.usernameNormalized,
    this.phone,
    this.email,
    required this.authPayload,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'usernameNormalized': usernameNormalized,
      'phone': phone,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [
    id,
    username,
    usernameNormalized,
    phone,
    email,
    authPayload,
  ];
}

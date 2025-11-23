import 'package:ecommerce/core/models/base_model.dart';

class AuthRegisterPayload extends BaseModel {
  final String email;
  final String password;
  AuthRegisterPayload({required this.email, required this.password});

  @override
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  @override
  List<Object?> get props => [];
}

import 'package:ecommerce/core/models/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel extends BaseModel {
  final UserCredential? userCredential;

  AuthModel({this.userCredential});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(userCredential: json['userCredential']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'userCredential': userCredential};
  }

  @override
  List<Object?> get props => [userCredential];
}

import 'package:ecommerce/core/models/base_model.dart';

class AuthModel extends BaseModel {
  AuthModel();

  factory AuthModel.fromJson() {
    return AuthModel();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

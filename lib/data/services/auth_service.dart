import 'package:ecommerce/core/utils/error.dart';
import 'package:ecommerce/data/models/payloads/auth_login_payload.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:ecommerce/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Repo return json
// Output: Actual model (class model)
// Middle layer:
// - Input: json from repository
// - Output: Actual model (class model) extends an abstract to always required to have fromJson() constructor
// Input: Class extends Default Payload, which will required to implement toJson() method
// -------
class AuthService implements AuthRepositoryImplementation {
  final AuthRepository repo;
  AuthService({AuthRepository? repo}) : repo = repo ?? AuthRepository();

  @override
  Future<void> logout() {
    try {
      final data = repo.logout();
      return data;
    } catch (e) {
      throw ServiceError(
        module: 'Authetication',
        message: e.toString(),
        functionName: 'Logout',
      ).toString();
    }
  }

  @override
  Future<UserCredential> register(AuthRegisterPayload payload) async {
    try {
      final data = repo.register(payload);
      return data;
    } catch (e) {
      throw ServiceError(
        module: 'Authetication',
        message: e.toString(),
        functionName: 'Register',
      ).toString();
    }
  }

  @override
  Future<UserCredential> login(AuthLoginPayload payload) {
    try {
      final data = repo.login(payload);
      return data;
    } catch (e) {
      throw ServiceError(
        module: 'Authetication',
        message: e.toString(),
        functionName: 'Login',
      ).toString();
    }
  }
}

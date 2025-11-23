import 'package:ecommerce/data/repositories/auth_repository.dart';

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
  Future<void> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register() {
    // TODO: implement register
    throw UnimplementedError();
  }
}

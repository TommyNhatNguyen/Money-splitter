// Should only fetch data from the database, do not convert anything
// Ouput: Json
// Input: Primitive data type
class AuthRepository extends AuthRepositoryImplementation {
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

abstract class AuthRepositoryImplementation<T> {
  // Required methods:
  Future<T> login();
  Future<T> logout();
  Future<T> register();
}

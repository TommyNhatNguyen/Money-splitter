import 'package:ecommerce/core/utils/error.dart';
import 'package:ecommerce/data/models/payloads/user_create_payload.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/data/repositories/user_repository.dart';
import 'package:ecommerce/data/services/auth_service.dart';

class UserService implements UserRepositoryImplementation {
  final UserRepository _repo;
  final AuthService _authService;
  UserService({UserRepository? repo, AuthService? authService})
    : _repo = repo ?? UserRepository(),
      _authService = authService ?? AuthService();

  @override
  Future<UserModel> create(UserCreatePayload payload) async {
    try {
      final authData = await _authService.register(payload.authPayload);
      final data = await _repo.create(
        UserCreatePayload(
          id: authData.user?.uid,
          username: payload.username,
          usernameNormalized: payload.usernameNormalized,
          authPayload: payload.authPayload,
        ),
      );
      return data;
    } catch (e) {
      throw ServiceError(
        module: 'User',
        message: e.toString(),
        functionName: 'Create',
      );
    }
  }
}

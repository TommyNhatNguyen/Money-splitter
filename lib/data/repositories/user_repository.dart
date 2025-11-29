import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/utils/error.dart';
import 'package:ecommerce/data/models/payloads/user_create_payload.dart';
import 'package:ecommerce/data/models/user_model.dart';

class UserRepository extends UserRepositoryImplementation {
  final FirebaseFirestore _db;

  UserRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<UserModel> create(UserCreatePayload payload) async {
    final jsonPayload = payload.toJson();
    try {
      await _db.collection('users').doc(payload.id).set(jsonPayload);
      return UserModel(
        id: payload.id ?? "",
        username: payload.username,
        usernameNormalized: payload.usernameNormalized,
        email: payload.email,
        phone: payload.phone != null ? int.tryParse(payload.phone ?? "") : null,
      );
    } on FirebaseException catch (e) {
      throw RepositoryError(
        source: "Firebase Firestore",
        module: 'User',
        functionName: 'Create',
        message: e.message ?? e.toString(),
      );
    } catch (e) {
      throw RepositoryError(
        source: 'Firebase Firestore',
        module: 'User',
        functionName: 'Create',
        message: e.toString(),
      );
    }
  }
}

abstract class UserRepositoryImplementation {
  Future<UserModel> create(UserCreatePayload payload);
}

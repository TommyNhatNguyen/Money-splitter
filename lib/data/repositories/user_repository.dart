import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/utils/error.dart';
import 'package:ecommerce/data/models/payloads/user_create_payload.dart';

class UserRepository extends UserRepositoryImplementation {
  final FirebaseFirestore _db;

  UserRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<void> create(UserCreatePayload payload) async {
    final jsonPayload = payload.toJson();
    try {
      final data = await _db.collection('users').add(jsonPayload);
      print(data);
    } on FirebaseException catch (e) {
      throw throw RepositoryError(
        source: "Firebase Firetore",
        module: 'User',
        functionName: 'Create',
        message: e.toString(),
      ).toString();
    } catch (e) {
      throw RepositoryError(
        source: 'Firebase Firestore',
        module: 'User',
        functionName: 'Create',
        message: e.toString(),
      ).toString();
    }
  }
}

abstract class UserRepositoryImplementation {
  Future<void> create(UserCreatePayload payload);
}

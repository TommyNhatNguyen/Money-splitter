// Should only fetch data from the database, do not convert anything
// Ouput: Json
// Input: Primitive data type
import 'package:ecommerce/core/utils/error.dart';
import 'package:ecommerce/data/models/payloads/auth_login_payload.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends AuthRepositoryImplementation {
  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw RepositoryError(
        module: 'Authentication',
        message: e.toString(),
      ).toString();
    }
  }

  @override
  Future<UserCredential> register(AuthRegisterPayload payload) async {
    final jsonPayload = payload.toJson();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: jsonPayload['email'],
            password: jsonPayload['password'],
          );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw throw RepositoryError(
        source: "Firebase Authentication",
        module: 'Authentication',
        message: e.toString(),
      ).toString();
    } catch (e) {
      throw RepositoryError(
        module: 'Authentication',
        message: e.toString(),
      ).toString();
    }
  }

  @override
  Future<UserCredential> login(AuthLoginPayload payload) async {
    final jsonPayload = payload.toJson();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: jsonPayload['email'],
        password: jsonPayload['password'],
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw throw RepositoryError(
        source: "Firebase Authentication",
        module: 'Authentication',
        message: e.toString(),
      ).toString();
    } catch (e) {
      throw RepositoryError(
        module: 'Authentication',
        message: e.toString(),
      ).toString();
    }
  }
}

abstract class AuthRepositoryImplementation {
  // Required methods:
  Future logout();
  Future<UserCredential> login(AuthLoginPayload payload);
  Future<UserCredential> register(AuthRegisterPayload payload);
}

import 'package:ecommerce/data/models/payloads/auth_login_payload.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class AuthRegistrationPressed extends AuthEvent {
  final AuthRegisterPayload payload;

  const AuthRegistrationPressed({required this.payload});

  @override
  List<Object?> get props => [payload];
}

final class AuthStateChanged extends AuthEvent {
  final User? user;

  const AuthStateChanged({this.user});

  @override
  List<Object?> get props => [user];
}

final class AuthLoginPressed extends AuthEvent {
  final AuthLoginPayload payload;

  const AuthLoginPressed({required this.payload});

  @override
  List<Object?> get props => [payload];
}

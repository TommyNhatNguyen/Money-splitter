import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {}

class AuthRegistrationPressed extends AuthEvent {
  final AuthRegisterPayload payload;

  AuthRegistrationPressed({required this.payload});

  @override
  List<Object?> get props => [];
}

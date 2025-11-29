import 'package:ecommerce/data/models/payloads/user_create_payload.dart';
import 'package:equatable/equatable.dart';

sealed class UserEvent extends Equatable {}

class UserCreatedPressed extends UserEvent {
  final UserCreatePayload payload;

  UserCreatedPressed({required this.payload});

  @override
  List<Object?> get props => [payload];
}

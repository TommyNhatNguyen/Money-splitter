import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/data/models/user_model.dart';

class UserState extends BaseState {
  final UserModel? user;

  const UserState({this.user, required super.requestStatus, super.error});

  UserState copyWith({
    UserModel? user,
    String? error,
    RequestStatus? requestStatus,
  }) {
    return UserState(
      user: user,
      requestStatus: requestStatus ?? this.requestStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [requestStatus, error];
}

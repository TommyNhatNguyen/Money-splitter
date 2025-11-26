import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends BaseState {
  final AuthStatus status;
  final User? user;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user,
    required super.requestStatus,
    super.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
    RequestStatus? requestStatus,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      requestStatus: requestStatus ?? this.requestStatus,
      error: error ?? this.error,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;

  @override
  List<Object?> get props => [status, user, requestStatus, error];
}

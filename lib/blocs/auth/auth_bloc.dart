import 'package:bloc/bloc.dart';
import 'package:ecommerce/blocs/auth/auth_event.dart';
import 'package:ecommerce/blocs/auth/auth_state.dart';
import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/data/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthState(requestStatus: RequestStatus.initial)) {
    on<AuthRegistrationPressed>(_register);
  }

  void _register(AuthRegistrationPressed event, Emitter<AuthState> emit) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    try {
      final data = await _authService.register(event.payload);
      if (data.user?.getIdToken() != null) {
        emit(
          state.copyWith(
            requestStatus: RequestStatus.completed,
            status: AuthStatus.authenticated,
            user: data.user,
            error: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            requestStatus: RequestStatus.completed,
            status: AuthStatus.unauthenticated,
            user: data.user,
            error: null,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(requestStatus: RequestStatus.error, error: e.toString()),
      );
    }
  }
}

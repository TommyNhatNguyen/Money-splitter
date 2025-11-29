import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/blocs/auth/auth_event.dart';
import 'package:ecommerce/blocs/auth/auth_state.dart';
import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  StreamSubscription<User?>? _authSubscription;
  final AuthService _authService = AuthService();

  AuthBloc()
    : super(
        AuthState(
          requestStatus: RequestStatus.initial,
          status: FirebaseAuth.instance.currentUser != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
        ),
      ) {
    _authSubscription = FirebaseAuth.instance.userChanges().listen((user) {
      add(AuthStateChanged(user: user));
    });

    on<AuthRegistrationPressed>(_register);
    on<AuthStateChanged>(_authStateChange);
  }

  void _authStateChange(AuthStateChanged event, Emitter<AuthState> emit) async {
    // FirebaseAuth.instance.signOut();
    if (event.user != null) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: event.user,
          error: null,
        ),
      );
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void _register(AuthRegistrationPressed event, Emitter<AuthState> emit) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    try {
      final data = await _authService.register(event.payload);
      if (data.user != null) {
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

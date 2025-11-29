import 'package:ecommerce/blocs/user/user_event.dart';
import 'package:ecommerce/blocs/user/user_state.dart';
import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/data/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserService();

  UserBloc() : super(UserState(requestStatus: RequestStatus.initial)) {
    on<UserCreatedPressed>(_create);
  }

  void _create(UserCreatedPressed event, Emitter<UserState> emit) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    try {
      final data = await _userService.create(event.payload);
      emit(state.copyWith(requestStatus: RequestStatus.completed, user: data));
    } catch (e) {
      emit(
        state.copyWith(requestStatus: RequestStatus.error, error: e.toString()),
      );
    }
  }
}

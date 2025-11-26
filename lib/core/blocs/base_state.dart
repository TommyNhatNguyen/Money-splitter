import 'package:equatable/equatable.dart';

enum RequestStatus { initial, loading, completed, error }

abstract class BaseState extends Equatable {
  final RequestStatus requestStatus;
  final String? error;

  const BaseState({required this.requestStatus, this.error});
}

import 'package:equatable/equatable.dart';

abstract class GenericState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenericInitial extends GenericState {}

class GenericLoading extends GenericState {}

class GenericLoaded extends GenericState {
  final dynamic data;

  GenericLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class GenericError extends GenericState {
  final String message;

  GenericError(this.message);

  @override
  List<Object?> get props => [message];
}

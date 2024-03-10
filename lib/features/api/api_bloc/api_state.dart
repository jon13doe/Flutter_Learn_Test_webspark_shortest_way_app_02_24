part of 'api_bloc.dart';

sealed class ApiState extends Equatable {
  const ApiState();
  
  @override
  List<Object> get props => [];
}

final class ApiInitial extends ApiState {}

class FetchInitial extends ApiState {}

class FetchProcess extends ApiState {}

class FetchSuccess extends ApiState {}

class FetchFailure extends ApiState {}

class PostInitial extends ApiState {}

class PostProcess extends ApiState {}

class PostSuccess extends ApiState {}

class PostFailure extends ApiState {}

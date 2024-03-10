part of 'api_bloc.dart';

sealed class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class InitialState extends ApiEvent {}

class DataFetchEvent extends ApiEvent {
  final String enteredUrl;

  const DataFetchEvent({required this.enteredUrl});
}

class DataPostEvent extends ApiEvent {
  final String enteredUrl;

  const DataPostEvent({required this.enteredUrl});

  
}
part of 'data_processing_bloc.dart';

sealed class DataProcessingState extends Equatable {
  const DataProcessingState();
  
  @override
  List<Object> get props => [];
}

final class DataProcessingInitial extends DataProcessingState {}

class ProcessingInitial extends DataProcessingState {}

class ProcessingProcess extends DataProcessingState {}

class ProcessingSuccess extends DataProcessingState {}

class ProcessingFailure extends DataProcessingState {}

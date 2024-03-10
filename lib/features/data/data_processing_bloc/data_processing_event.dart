part of 'data_processing_bloc.dart';

sealed class DataProcessingEvent extends Equatable {
  const DataProcessingEvent();

  @override
  List<Object> get props => [];
}

class DataProcessing extends DataProcessingEvent {
  final List<GameData> listOfData;

  const DataProcessing({required this.listOfData});
}
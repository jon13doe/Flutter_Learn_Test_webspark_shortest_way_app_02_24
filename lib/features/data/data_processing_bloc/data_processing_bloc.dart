import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../a_star_2d.dart';
import '../models/models.dart';

part 'data_processing_event.dart';
part 'data_processing_state.dart';

class DataProcessingBloc
    extends Bloc<DataProcessingEvent, DataProcessingState> {
  DataProcessingBloc() : super(DataProcessingInitial()) {
    on<DataProcessing>((event, emit) async {
      emit(ProcessingProcess());
      try {
        for (var element in event.listOfData) {
          final path = aStar2D(element.fieldToMaze());
          element.steps =
              path.map((tile) => PositionData(x: tile.x, y: tile.y)).toList();
        }
        emit(ProcessingSuccess());
      } catch (e) {
        emit(ProcessingFailure());
        log(e.toString());
      }
    });
  }
}

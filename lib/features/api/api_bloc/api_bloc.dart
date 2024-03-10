import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/models/models.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  List<GameData> listOfTasks = [];

  ApiBloc() : super(ApiInitial()) {
    on<InitialState>((event, emit) {
      emit(FetchInitial());
      listOfTasks = [];
    });

    on<DataFetchEvent>((event, emit) async {
      emit(FetchProcess());
      try {
        final response = await http.get(Uri.parse(event.enteredUrl));
        log('FetchSuccess');
        if (response.statusCode == 200) {
          final responseData =
              ResponseData.fromJson(json.decode(response.body));
          for (var element in responseData.data) {
            listOfTasks.add(element);
          }
          emit(FetchSuccess());
          log('FetchSuccess emitted, ${listOfTasks.length} elements takes');
        } else {
          emit(FetchFailure());
          log('Failed to load data: ${response.statusCode}');
        }
      } catch (e) {
        emit(FetchFailure());
        log(e.toString());
      }
    });

    on<DataPostEvent>((event, emit) async {
      if (listOfTasks.isNotEmpty) {
        List<Map<String, dynamic>> postList = [];

        for (var element in listOfTasks) {
          postList.add(element.toJson());
        }

        var headers = {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        };

        var body = jsonEncode(postList);

        try {
          final response = await http.post(Uri.parse(event.enteredUrl),
              headers: headers, body: body);

          if (response.statusCode == 200) {
            emit(PostSuccess());
            log('Post successful');
          } else {
            emit(PostFailure());
            log('Failed to post data: ${response.statusCode}');
          }
        } catch (e) {
          emit(PostFailure());
          log(e.toString());
        }
      } else {
        emit(PostFailure());
        log('List of tasks is empty, nothing to post');
      }
    });
  }

  List<GameData> getListOfTasks() {
    return listOfTasks;
  }
}

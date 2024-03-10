import 'package:flutter_bloc/flutter_bloc.dart';

class UrlBloc extends Cubit<String> {
  UrlBloc() : super('');

  void saveEnteredUrl(String url) {
    emit(url);
  }
}
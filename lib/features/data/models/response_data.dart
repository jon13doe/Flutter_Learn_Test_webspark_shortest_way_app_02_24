import 'game_data.dart';

class ResponseData {
  final bool error;
  final String message;
  final List<GameData> data;

  ResponseData({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    List<GameData> dataList = [];
    if (json['data'] != null) {
      dataList = List<GameData>.from(
        json['data'].map(
          (gameData) => GameData.fromJson(gameData),
        ),
      );
    }
    return ResponseData(
      error: json['error'],
      message: json['message'],
      data: dataList,
    );
  }
}
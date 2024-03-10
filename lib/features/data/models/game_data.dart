import '../a_star_2d.dart';
import 'position_data.dart';

class GameData {
  final String id;
  final List<String> field;
  final PositionData start;
  final PositionData end;
  List<PositionData> steps;

  GameData({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
    required this.steps,
  });

  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: PositionData.fromJson(json['start']),
      end: PositionData.fromJson(json['end']),
      steps: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "result": {
        "steps": steps.map((e) => e.positionToMap()).toList(),
        "path": stepsToString()
      }
    };
  }

  String stepsToString() {
    if (steps.isEmpty) {
      return 'no steps';
    } else {
      List<String> stepsString = [];
      for (PositionData item in steps) {
        stepsString.add(('(${item.x},${item.y})'));
      }
      return stepsString.join('->');
    }
  }



  Maze fieldToMaze() {
    List<List<String>> fieldList =
        field.map((e) => e.split('').toList()).toList();
    fieldList[start.y][start.x] = 's';
    fieldList[end.y][end.x] = 'g';

    List<String> listOfStrings = [];
    for (var element in fieldList) {
      listOfStrings.add(element.join(''));
    }

    String fieldString = listOfStrings.join('\n');

    Maze maze = Maze.parse(fieldString);
    return maze;
  }

  @override
  String toString() {
    return 'id: $id, field: ${fieldToMaze()}, steps: ${stepsToString()}';
  }
}

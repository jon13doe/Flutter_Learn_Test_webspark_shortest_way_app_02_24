import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../data/models/models.dart';

class MyPreviewScreen extends StatefulWidget {
  final GameData game;

  const MyPreviewScreen({
    super.key,
    required this.game,
  });

  @override
  State<MyPreviewScreen> createState() => _MyPreviewScreenState();
}

class _MyPreviewScreenState extends State<MyPreviewScreen> {
  final Color start = HexColor('#64FFDA');
  final Color end = HexColor('#009688');
  final Color blocked = HexColor('#000000');
  final Color road = HexColor('#4CAF50');
  final Color empty = HexColor('#FFFFFF');

  Color fieldElementColor({required List<dynamic> element}) {
    final GameData game = widget.game;
    final List<PositionData> path = game.steps;
    
    final int col = element[1];
    final int row = element[2];


    if (col == game.start.x && row == game.start.y) {
      return start;
    } else if (col == game.end.x && row == game.end.y) {
      return end;
    } else if (element[0] == 'X') {
      return blocked;
    } else if (path.any((pos) => pos.x == col && pos.y == row)) {
      return road;
    } else {
      return empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final List<List<dynamic>> field = [];

    for (int j = 0; j < widget.game.field.length; j++) {
      List<String> row = widget.game.field[j].split('');
      for (int i = 0; i < row.length; i++) {
        field.add([row[i], i, j]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.tertiary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          'Preview screen',
          style: TextStyle(color: theme.secondary),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: field.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.game.field.length,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: fieldElementColor(element: field[index]),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text('(${field[index][1]}, ${field[index][2]})'),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: kToolbarHeight,
            child: Center(
              child: Column(
                children: [
                  const Text('Shortcut'),
                  Text(widget.game.stepsToString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

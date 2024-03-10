import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_bloc/api_bloc.dart';
import '../data/models/models.dart';
import 'preview_screen.dart';

class MyResultScreen extends StatefulWidget {
  const MyResultScreen({super.key});

  @override
  State<MyResultScreen> createState() => _MyResultScreenState();
}

class _MyResultScreenState extends State<MyResultScreen> {
  late final ApiBloc apiBloc;

  @override
  void initState() {
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    List<GameData> dataList = apiBloc.getListOfTasks();

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
          'Result screen',
          style: TextStyle(color: theme.secondary),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final item = dataList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.amber[100],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPreviewScreen(
                      game: item,
                    ),
                  ),
                );
              },
              title: Center(
                child: Text(
                  item.stepsToString(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

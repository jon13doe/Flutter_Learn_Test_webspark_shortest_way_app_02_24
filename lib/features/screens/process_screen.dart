import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_webspark_shortest_way_app_02_24/features/data/data_processing_bloc/data_processing_bloc.dart';

import '../api/api_bloc/api_bloc.dart';
import '../data/url_bloc.dart';
import 'result_list_screen.dart';

class MyProcessScreen extends StatefulWidget {
  const MyProcessScreen({super.key});

  @override
  State<MyProcessScreen> createState() => _MyProcessScreenState();
}

class _MyProcessScreenState extends State<MyProcessScreen> {
  late final ApiBloc apiBloc;
  late final DataProcessingBloc dataProcessingBloc;

  @override
  void initState() {
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    dataProcessingBloc = BlocProvider.of<DataProcessingBloc>(context);
    dataProcessingBloc
        .add(DataProcessing(listOfData: apiBloc.getListOfTasks()));
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    double progresValue = 1;

    final enteredUrl = context.select((UrlBloc bloc) => bloc.state);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.tertiary,
        leading: IconButton(
          onPressed: () {
            apiBloc.add(InitialState());
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          'Process screen',
          style: TextStyle(color: theme.secondary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<DataProcessingBloc, DataProcessingState>(
                    builder: (context, state) {
                      if (state is ProcessingSuccess) {
                        return const Text(
                          'All Calculations has finnished, you can send your results to server.',
                          textAlign: TextAlign.center,
                        );
                      } else if (state is ProcessingFailure) {
                        return const Text('Something went wrong.');
                      } else {
                        return const Text('Calculations in progress...');
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('${progresValue * 100}%'),
                  ),
                  CircularProgressIndicator(
                    value: progresValue,
                    color: theme.tertiary,
                  ),
                ],
              ),
            ),
            BlocBuilder<DataProcessingBloc, DataProcessingState>(
              builder: (context, state) {
                if (state is ProcessingSuccess) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        apiBloc.add(DataPostEvent(enteredUrl: enteredUrl));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyResultScreen()),
                        );
                      },
                      child: Container(
                        height: kToolbarHeight,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: theme.tertiary,
                          borderRadius:
                              BorderRadius.circular(kToolbarHeight / 2),
                        ),
                        child: Center(
                          child: BlocBuilder<ApiBloc, ApiState>(
                              builder: (context, state) {
                            if (state is PostSuccess) {
                              return Text('View result');
                            } else {
                              return Text('Send result to server');
                            }
                          }),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_webspark_shortest_way_app_02_24/features/screens/screens.dart';

import '../api/api_bloc/api_bloc.dart';
import '../api/api_url.dart';
import '../data/url_bloc.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late final ApiBloc apiBloc;

  @override
  void initState() {
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  final TextEditingController _urlController = TextEditingController();
  final String rightUrl = apiUrl;
  String _errorMessage = '';

  emptyTextField() {
    _urlController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.tertiary,
        title: Text(
          'Home Screen',
          style: TextStyle(color: theme.secondary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set valid API base URL in order to continue'),
            const SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _urlController.text = rightUrl;
                  },
                  icon: const Icon(
                    Icons.sync_alt,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 16),
                BlocListener<ApiBloc, ApiState>(
                  listener: (context, state) {
                    if (state is FetchInitial) {
                      emptyTextField();
                    }
                  },
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    controller: _urlController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      errorText:
                          _errorMessage.isNotEmpty ? _errorMessage : null,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<ApiBloc, ApiState>(
                    builder: (context, state) {
                      if (state is FetchSuccess) {
                        return TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyProcessScreen()));
                          },
                          child: Container(
                            height: kToolbarHeight,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: theme.tertiary,
                              borderRadius:
                                  BorderRadius.circular(kToolbarHeight / 2),
                            ),
                            child: const Center(
                              child: Text('Start counting process'),
                            ),
                          ),
                        );
                      } else {
                        return TextButton(
                          onPressed: () {
                            final String enteredUrl =
                                _urlController.text.trim();

                            if (enteredUrl.isNotEmpty) {
                              if (enteredUrl == rightUrl) {
                                setState(() {
                                  _errorMessage = '';
                                });

                                BlocProvider.of<UrlBloc>(context)
                                    .saveEnteredUrl(enteredUrl);

                                apiBloc.add(
                                    DataFetchEvent(enteredUrl: enteredUrl));
                              } else {
                                setState(() {
                                  _errorMessage = 'Enter valid API base URL';
                                });
                              }
                            } else {
                              setState(() {
                                _errorMessage = 'URL cannot be empty';
                              });
                            }
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
                              child: Text('Start fetching process',
                                  style: TextStyle(color: theme.secondary)),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

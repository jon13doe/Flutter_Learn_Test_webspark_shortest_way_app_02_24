import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/api_bloc/api_bloc.dart';
import 'data/data_processing_bloc/data_processing_bloc.dart';
import 'data/url_bloc.dart';
import 'my_app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UrlBloc>(
          create: (context) => UrlBloc(),
        ),
        BlocProvider<ApiBloc>(
          create: (context) => ApiBloc(),
        ),
        BlocProvider<DataProcessingBloc>(
          create: (context) => DataProcessingBloc(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}

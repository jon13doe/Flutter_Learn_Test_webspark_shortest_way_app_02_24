import 'package:flutter/material.dart';

import 'screens/screens.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.white,
          tertiary: Colors.blue,
        ),
      ),
      home: const MyHomeScreen(),
    );
  }
}

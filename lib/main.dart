import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_screen/home_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Montserrat',
              bodyColor: kSecondaryColor,
            ),
      ),
      home: const HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'App.dart';
import 'constants/Colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(
          colorScheme: ColorScheme.light(
            primary: primaryColor,
            secondary: secondaryColor,
          ),
          textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'OpenSans',
            bodyColor: primaryColor,
          ),
          useMaterial3: true
      ),
      home: const App(),
    );
  }
}



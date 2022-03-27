import 'package:flutter/material.dart';
import './pages/home/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Climate',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const Scaffold(
          body: HomePage(),
        ));
  }
}

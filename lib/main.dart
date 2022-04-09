import 'package:climate_mobile/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'pages/home/home_page.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<Api>(Api());

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

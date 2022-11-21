import 'package:flutter/material.dart';
import 'package:wheather_app_clone/routes.dart';
import 'package:wheather_app_clone/utils/time_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => MyRouter.generateRoute(settings),
      initialRoute: splashScreen,
    );
  }
}
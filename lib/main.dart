import 'package:flutter/material.dart';
import 'package:weather_app/pages/weatger_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        fontFamily: 'Rajdhani',
        primarySwatch: Colors.blue,
      ),
      home: const WeatherHome(),
    );
  }
}

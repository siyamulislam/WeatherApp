import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/weather_home.dart';
import 'package:weather_app/providers/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {





    return ChangeNotifierProvider(
      create: ( context) =>WeatherProvider() ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          fontFamily: 'Rajdhani',
          primarySwatch: Colors.blue,
        ),
        home: const WeatherHome(),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/current_model.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_utils.dart';

class WeatherProvider extends ChangeNotifier{
  late CurrentWeatherRes _current;
  late ForecastWeatherRes _forecast;
  CurrentWeatherRes get getCurrentWeatherData=>_current;
  ForecastWeatherRes get getCurrentForecastData=>_forecast;

  Future fetchCurrentData() async{
    final url ='https://api.openweathermap.org/data/2.5/weather?lat=23.8103&lon=90.4125&units=metric&appid=$weather_api_key';
    final res = await http.get(Uri.parse(url));
    final resMap = json.decode(res.body);
    _current=CurrentWeatherRes.fromJson(resMap);
    notifyListeners();
  }
  Future fetchForecastData() async{
    final url ='https://api.openweathermap.org/data/2.5/forecast?q=bogra&units=metric&appid=$weather_api_key';
    final res = await http.get(Uri.parse(url));
    final resMap = json.decode(res.body);
    _forecast=ForecastWeatherRes.fromJson(resMap);
    // _forecast.list[0].main.temp;
    notifyListeners();
  }


}
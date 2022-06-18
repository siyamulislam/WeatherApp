import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/current_model.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_utils.dart';

class WeatherProvider extends ChangeNotifier{
  late CurrentWeatherRes _currert;
  late ForecastWeatherRes _forecast;
  CurrentWeatherRes get getCurrentWeatherData=>_currert;
  ForecastWeatherRes get getCurrentForecastData=>_forecast;

  Future fetchCurrentData() async{
    final url ='https://api.openweathermap.org/data/2.5/weather?q=dhaka&units=metric&appid=$weather_api_key';
    final res = await http.get(Uri.parse(url));
    final resMap = json.decode(res.body);
    _currert=CurrentWeatherRes.fromJson(resMap);
    notifyListeners();
  }
  Future fetchForecastData() async{
    final url ='https://api.openweathermap.org/data/2.5/forecast?q=dhaka&units=metric&appid=$weather_api_key';
    final res = await http.get(Uri.parse(url));
    final resMap = json.decode(res.body);
    _forecast=ForecastWeatherRes.fromJson(resMap);
    // _forecast.list[0].main.temp;
    notifyListeners();
  }


}
import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:weather_app/weather_utils.dart';

class ForecastItem extends StatelessWidget {
  const ForecastItem({Key? key, required this.forecastElement})
      : super(key: key);
  final ForecastElement forecastElement;

  // ForecaastItem(this.forecastElement);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(getFormattedDate(forecastElement.dt, "EEE"),style: const TextStyle(fontSize: 16),),
            Image.network(
              'https://openweathermap.org/img/wn/${forecastElement.weather[0].icon}@2x.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            Text('${forecastElement.main.tempMax.round()} / ${forecastElement.main.tempMin.round()}\u00B0C',style: const TextStyle(fontSize: 16),),
          ],
        ),
    );
  }
}

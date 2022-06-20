

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/weather_utils.dart';
import 'package:weather_app/widgets/forecast_item.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  bool isLoading = true;

  late WeatherProvider weatherProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.fetchCurrentData().then((_) {
      weatherProvider.fetchForecastData().then((_){
        setState(() {
          isLoading = false;
        });
      });


    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Home'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Consumer<WeatherProvider>(
                builder: (context, provider, _) => Column(
                  children: [
                    Text(
                        getFormattedDate(provider.getCurrentWeatherData.dt,
                            'EEE, dd, MMM, yyyy'),
                        style: const TextStyle(
                          fontSize: 30,
                        )),
                    Text(
                      '${provider.getCurrentWeatherData.main.temp.round()}\u00B0C',
                      style: const TextStyle(
                        fontSize: 60,
                      ),
                    ),

                    Text('feels like: ${provider.getCurrentWeatherData.main.feelsLike.round()}\u00B0C',style: const TextStyle(fontSize: 30,), ),
                    // Text('${provider.getCurrentForecastData.list[0].weather[0].icon}',style: const TextStyle(fontSize: 30,), ),

                    Text(
                      'Location: ${provider.getCurrentWeatherData.name}, ${provider.getCurrentWeatherData.sys.country}',
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Row(
                      children: [
                        Image.network( 'https://openweathermap.org/img/wn/${provider.getCurrentWeatherData.weather[0].icon}@2x.png', width: 80,height: 80,fit: BoxFit.cover,),
                         Text(
                          provider.getCurrentWeatherData.weather[0].main +
                              ', ' +
                              provider
                                  .getCurrentWeatherData.weather[0].description,
                          style: const TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.getCurrentForecastData.list.length,
                        itemBuilder: (context,index)=>ForecastItem(forecastElement: provider.getCurrentForecastData.list[index]),


                      ),
                    ),


                  ],
                ),
              ),
            ),
    );
  }
}

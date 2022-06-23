import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
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
  // Position? _position;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
   // Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) => print(position.latitude));
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

  // void getCurrentLocation() async {
  //   Position position=await _determinePosition();
  //   setState(() {
  //     _position=position;
  //   });
  // }

  // Future<Position> _determinePosition() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.checkPermission();
  //   if(permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if(permission == LocationPermission.denied) {
  //       return Future.error('Location Permissions are denied');
  //     }
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

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
          : Stack(children: [
        Opacity(opacity:0.5,child: Image.asset('images/weather1.png',height: double.infinity,width:double.infinity,fit: BoxFit.cover,)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Consumer<WeatherProvider>(
              builder: (context, provider, _) => Column(
                children: [
                  Text(
                      getFormattedDate(provider.getCurrentWeatherData.dt,
                          'EEE, dd, MMM, yyyy'),
                      style: const TextStyle(
                        fontSize: 25,
                      )),
                  Text(
                    '${provider.getCurrentWeatherData.main.temp.round()}\u00B0C',
                    style: const TextStyle(
                      fontSize: 60,
                    ),
                  ),

                  Text('feels like: ${provider.getCurrentWeatherData.main.feelsLike.round()}\u00B0C',style: const TextStyle(fontSize: 25,), ),
                  // _position != null ? Text('Current Location: ' + _position.toString()) : const Text('No Location Data'),
                  // Text('${provider.getCurrentForecastData.list[0].weather[0].icon}',style: const TextStyle(fontSize: 30,), ),

                  Text(
                    'Location: ${provider.getCurrentWeatherData.name}, ${provider.getCurrentWeatherData.sys.country}',
                    style: const TextStyle(
                      fontSize: 25,
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
                        style: const TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Text('4 Hour Weather Forecast',style: TextStyle(fontSize: 22,),),
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
        )
      ],),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getCurrentLocation,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

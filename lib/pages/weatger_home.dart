import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late WeatherProvider weatherProvider;
  bool isLoading=true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    double  date =weatherProvider.getCurrentWeatherData.main.temp;
    weatherProvider.fetchCurrentData().then((_)  {
      setState(() {
        isLoading=false;
      });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Weather Home'),
      ),
      body: isLoading? const Center(child: CircularProgressIndicator(),)
          :
      Center(
        child: Consumer<WeatherProvider>(
          builder: (context, provider, _)=> Column(
            children: [
              const Text( 'June 18 2022',style: TextStyle(fontSize: 30,)),
              Text( '${provider.getCurrentWeatherData.main.temp.round()}\u00B0C',style: const TextStyle(fontSize: 60,),),
              Text( 'feels like: ${provider.getCurrentWeatherData.main.feelsLike.round()}\u00B0C',style: const TextStyle(fontSize: 30,),),
              Row(
                children:  [
                  Image.network('https://sa.kapamilya.com/absnews/abscbnnews/media/2022/news/05/18/jma.jpg',width: 80,height: 80,fit: BoxFit.cover,),
                  const Text("Heavy Rain", style: TextStyle(fontSize: 30),)
                ],)
            ],
          ),
        ),
      ),
    );
  }
}

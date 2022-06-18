import 'package:flutter/material.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Weather Home'),
      ),
      body:  Center(
        child: Column(
          children: [
            const Text( 'June 18 2022',style: TextStyle(fontSize: 30,)),
            const Text( '28\u00B0C',style: TextStyle(fontSize: 65,fontWeight: FontWeight.bold),),
            const Text( 'feels like: 40\u00B0C',style: TextStyle(fontSize: 30,),),
            Row(
              children:  [
                Image.network('https://sa.kapamilya.com/absnews/abscbnnews/media/2022/news/05/18/jma.jpg',width: 80,height: 80,fit: BoxFit.cover,),
                const Text("Heavy Rain", style: TextStyle(fontSize: 30),)
              ],)
          ],
        ),
      ),
    );
  }
}

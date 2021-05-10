import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/weather.dart';
import 'package:weatherify/user_location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DisplayWeather extends StatefulWidget {
  const DisplayWeather({Key key}) : super(key: key);

  @override
  _DisplayWeatherState createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {

  WeatherFactory wf = new WeatherFactory("af9b20f8cd3f81c020611328b534f316");
  double temperature,tempMin,tempMax;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTemp();
  }
  Future<double> getTemp() async{
    Weather w = await wf.currentWeatherByLocation(newLat, newLong);
    temperature = w.temperature.celsius;
    tempMin = double.parse((w.tempMin.celsius).toStringAsFixed(2));
    tempMax = double.parse((w.tempMax.celsius).toStringAsFixed(2));
    return w.temperature.celsius;
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: getTemp(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
          print( "This is invoked from Future builder");
          print(snapshot.hasData);
          if(snapshot.data == null){
            return Container(
              child: Container(
                color: Colors.blue[100],
                child: Center(
                  child: SpinKitSquareCircle(
                    color: Colors.white,
                    size: 50.0,
                  )
                ),
              ),
            );
          }
          else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(child: SizedBox(width: MediaQuery.of(context).size.width, height: 50,)),
                  Text("Current Temperature: $temperature" ),
                  SizedBox(height:  20),
                  Text("Minimum Temperature: $tempMin" ),
                  SizedBox(height:  20),
                  Text("Maximum Temperature: $tempMax" ),
                  
                ],
              ),
            );
          }}

      )
    );
  }
}




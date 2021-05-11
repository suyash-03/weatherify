import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/weather.dart';
import 'package:weatherify/HomeScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'user_location.dart';

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
    temperature = double.parse((w.temperature.celsius).toStringAsFixed(2));
    tempMin = double.parse((w.tempMin.celsius).toStringAsFixed(2));
    tempMax = double.parse((w.tempMax.celsius).toStringAsFixed(2));
    return w.temperature.celsius;
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: getTemp(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
          print( "This is invoked from Future builder");
          print(snapshot.hasData);
          if(snapshot.data == null){
            return Container(
              child: Container(
                color: Colors.blue,
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
                  Container(child: SizedBox(width: MediaQuery.of(context).size.width, height: 0,)),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                    height: MediaQuery.of(context).size.height/2,
                      child: Center(
                          child: Text("$temperature ° C",style: TextStyle(
                            fontSize: 50,
                            fontFamily: "Fjalla",
                            fontWeight: FontWeight.bold
                          ), )
                      )
                  ),
                  SizedBox(height:  20),
                  Text("Maximum Temperature: $tempMax",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ), ),
                  SizedBox(height:  20),
                  Text("Minimum Temperature: $tempMin" ,style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,

                  ),),
                  
                ],
              ),
            );
          }}

      )
    );
  }
}




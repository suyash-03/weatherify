import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:weather/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'locationDetails.dart';
import 'package:location/location.dart';

class DisplayWeather extends StatefulWidget {
  const DisplayWeather({Key key}) : super(key: key);
  @override
  _DisplayWeatherState createState() => _DisplayWeatherState();
}


class _DisplayWeatherState extends State<DisplayWeather> {

  WeatherFactory wf = new WeatherFactory("9dc55dc64829123d2a0c5ee4cf0b8ba2");
  double latD,longD;
  String temperature ="";
  String tempMax = "";
  String tempMin ="";
  String weatherDesc = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitDetails();
  }

  Future<Weather> waitDetails() async{

    LocationDetails _locationDetails = LocationDetails();
    LocationData _locationData;
    _locationDetails.getPermisson();
    _locationData = await _locationDetails.getLocation();
    latD=_locationData.latitude.toDouble();
    longD=_locationData.longitude.toDouble();

    WeatherFactory wf = new WeatherFactory("9dc55dc64829123d2a0c5ee4cf0b8ba2");
    Weather w = await wf.currentWeatherByLocation(latD, longD);
    temperature = double.parse(w.temperature.celsius.toString()).toStringAsFixed(2);
    tempMax= double.parse(w.tempMax.celsius.toString()).toStringAsFixed(2);
    tempMin = double.parse(w.tempMin.celsius.toString()).toStringAsFixed(2);
    weatherDesc = w.weatherDescription.toString();

    print("Future from Weather Screen");
    print(temperature);
    print(w.weatherDescription);

    print("Future from Weather Screen");
    return w;

  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: waitDetails(),
          builder: (BuildContext context, AsyncSnapshot<Weather> snapshot){
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(temperature + " °C",style: TextStyle(
                                fontSize: 50,
                                fontFamily: "Fjalla",
                                fontWeight: FontWeight.bold
                              ), )
                          ),
                          Center(
                            child: Text(weatherDesc,style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w200
                            ),),
                          ),
                        ],
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




import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'locationDetails.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class WeatherManual extends StatelessWidget {
  final cityName;
  const WeatherManual({Key key,this.cityName}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    WeatherFactory wf = new WeatherFactory("9dc55dc64829123d2a0c5ee4cf0b8ba2");
    String temperature ="";
    String tempMax = "";
    String tempMin ="";
    String weatherDesc = "";




    // Details Function

    Future<Weather> waitDetails() async{

      LocationDetails _locationDetails = LocationDetails();
      _locationDetails.getPermisson();

      WeatherFactory wf = new WeatherFactory("9dc55dc64829123d2a0c5ee4cf0b8ba2");
      Weather w = await wf.currentWeatherByCityName(cityName);
      temperature = double.parse(w.temperature.celsius.toString()).toStringAsFixed(2);
      tempMax= double.parse(w.tempMax.celsius.toString()).toStringAsFixed(2);
      tempMin = double.parse(w.tempMin.celsius.toString()).toStringAsFixed(2);
      weatherDesc = w.weatherDescription.toString();

      print("Future from Weather Screen");
      print(temperature);
      print(w.weatherDescription);

      print("Future from Weather Screen");
      print(cityName);
      return w;
    }

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent,
        ),
        body: FutureBuilder(
            future: waitDetails(),
            builder: (BuildContext context, AsyncSnapshot<Weather> snapshot){
              print( "This is invoked from Future builder Manual");
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
                          fontFamily: "Fjalla"

                      ), ),
                      SizedBox(height:  20),
                      Text("Minimum Temperature: $tempMin" ,style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Fjalla"

                      ),),
                      SizedBox(height: 180,),
                      Text("Showing Weather Details of $cityName")

                    ],
                  ),
                );
              }}

        )
    );
  }
}

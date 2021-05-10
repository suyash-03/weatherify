import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_location.dart';
import 'package:flutter_button/flutter_button.dart';
import 'package:location/location.dart';
import 'weather_screen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

  }



class _HomeScreenState extends State<HomeScreen> {

  Location location = new Location();

  LocationData _locationData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermisson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: (MediaQuery.of(context).size.height/4),),
                Text('Hi',style: TextStyle(
                  fontSize: 80.0,
                  fontFamily: 'Fjalla',
                ),),
                Text('There !',style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: Colors.greenAccent[400],
                  fontSize: 90.0,
                  fontFamily: 'Fjalla',
                ),),
                FutureBuilder(
                  future: returnLatitude(),
                  builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  print(snapshot.hasData);
                  if(snapshot.data == null){
                   return Text('Loading');
                  }
                  else {
                  return Text('Latitude: $newLat');
                  }
                }
                ),
                FutureBuilder(
                    future: returnLongitude(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data);

                      if (snapshot.data == null) {
                        return Text('Loading');
                      }
                      else {
                        return Text('Longitude: $newLong');
                      }
                    }
                )





                
                
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueAccent[100],

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width,),
                  SizedBox(height: MediaQuery.of(context).size.height/3,),
                  AnimatedHoverButton(
                    title: "See Weather at your Location",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DisplayWeather()));
                    },
                    titleSize: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}


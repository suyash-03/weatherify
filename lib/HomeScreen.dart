import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_location.dart';
import 'package:flutter_button/flutter_button.dart';
import 'package:location/location.dart';
import 'weather_screen.dart';
import 'locationDetails.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
  class _HomeScreenState extends State<HomeScreen> {
  double latD,longD;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitDetails();
  }

  Future waitDetails() async {
    LocationDetails _locationDetails = LocationDetails();
    LocationData _locationData;
    _locationDetails.getPermisson();
    _locationData = await _locationDetails.getLocation();
    latD=_locationData.latitude.toDouble();
    longD=_locationData.longitude.toDouble();


    print("Future from Home Screen");
    print(_locationData.latitude);
    print(_locationData.longitude);
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
                ),
                ),
                //Future Builder Goes Here
                FutureBuilder(
                  future: waitDetails(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.data==null){
                        print(snapshot.hasData);

                        return Text("    The App Automatically \n"
                            "    determines your Location",style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Montserrat"
                        ),);
                      }
                      else{
                        return Text("Latitude :$latD \n"
                            "Longitude: $longD ");
                      }
                    }
                )


              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                color: Colors.blueAccent,
              ),
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


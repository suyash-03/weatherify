import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/flutter_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherify/locationDetails.dart';
import 'weather_screen.dart';
import 'manual_location.dart';
import 'weather_manual.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
  class _HomeScreenState extends State<HomeScreen> {
  String  cityName ="";
  LocationDetails _locationDetails =LocationDetails();
  final _formkey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationDetails.getPermisson();
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
                SizedBox(height: (MediaQuery.of(context).size.height/6),),
                Text('Hi',style: TextStyle(
                  fontSize: 80.0,
                  fontFamily: 'Fjalla',
                ),),
                Text('There !',style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: Colors.greenAccent[400],
                  fontSize: 90.0,
                  fontFamily: 'Fjalla',),),
                Text(" Weatherify: \n"
                      " The Weather App for dummies",style: TextStyle(
                           fontSize: 15,
                       fontFamily: "Montserrat",))
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
                  SizedBox(height: MediaQuery.of(context).size.height/25,),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Form(
                      key: _formkey,
                      child: TextFormField(
                        validator: (val) => val.isEmpty? 'Please Enter a City Name':null,
                        decoration: InputDecoration(
                        filled: true,
                          fillColor: Colors.white,
                          helperText: 'Enter City Name here and Click on the Button below',
                          prefixIcon: Icon(Icons.location_city_rounded),

                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Enter City Name',
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),

                      ),
                      onChanged: (String str){
                        setState(() {
                          cityName = str;
                        });
                      },),
                    ),
                  ),
                  SizedBox(height: 20,),

                  AnimatedHoverButton(title: "Search by City",
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    onTap: () {
                    if(_formkey.currentState.validate()){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WeatherManual(cityName:cityName)));
                    }}
                    , titleSize: 20,),
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  AnimatedHoverButton(
                    title: "Get Location Automatically", onTap: ()
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  DisplayWeather()));
                  }, titleSize: 20,
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


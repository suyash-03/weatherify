import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


 Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  double newLat;
  double newLong;

  //Request Location Popup
  void getPermisson() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    print(_locationData);

    await returnLatitude();
    await returnLongitude();


  }

  Future<double> returnLatitude() async
  {
    newLat = _locationData.latitude;
    print(newLat);
    return newLat;
  }
  Future<double> returnLongitude() async
  {
    newLong = _locationData.longitude;
    print(newLong);
    return newLong;
  }




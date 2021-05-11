import 'package:location/location.dart';

class LocationDetails{

  Location location = new Location();
  LocationData _locationData;
  double latitude;
  double longitude;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Future<LocationData> getLocation() async{
    _locationData = await location.getLocation();
    return _locationData;
  }
  double locationLatitude() {
    return latitude=_locationData.latitude.toDouble();
  }
  double locationLongitude(){
    return longitude=_locationData.longitude.toDouble();
  }

  void getPermisson() async{
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
  }
}
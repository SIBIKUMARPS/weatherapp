

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app_interviw/models/weather_model.dart';

class weatherProvider extends ChangeNotifier {


///........................to get location............................
Location location = new Location();

late bool _serviceEnabled;
late PermissionStatus _permissionGranted;
late LocationData _locationData;




getcurentLocation()async{
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
}








//-------------to get weather details ----------------
  Future<void> getWeatherReport(String latitude, String longitude) async {
    WeatherDetailsModel? weatherReport;
  
    String uri =
        "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=8.570253859088986&lon=76.85196127742529&dt=1697962033&appid=bac97938dfcac7bb4def50d381e18bbd";
    try {
      var response = await Dio().post(uri,
          options: Options(headers: {
            "Content-Type": 'application/json',
          }));
      print("the response iss ${response.data}");

      weatherReport = WeatherDetailsModel.fromJson(response.data);
      notifyListeners();
    } on DioError catch (e) {
      print(e);
    }
  }
}

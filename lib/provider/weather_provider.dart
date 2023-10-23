// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:weather_app_interviw/models/weather_model.dart';

class weatherProvider extends ChangeNotifier {
  ///........................to get location............................
  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationPermission? _locationData;
  Position? curentPosition;
  TextEditingController locationController = new TextEditingController();
  String? currentAddress;
  WeatherDetailsModel? weatherReport;
  String? latitude;
  String? longitude;

  getLocationbyData() async {
    try {
      List<geo.Location> locations =
          await geo.locationFromAddress(locationController.text);
      print(
          "the location is locations ${locations[0].latitude} ${locations[0].longitude}");
      latitude = locations[0].latitude.toString();
      longitude = locations[0].longitude.toString();
      currentAddress = locationController.text;
      notifyListeners();
    } catch (e) {
      print("e is $e");
    }
  }

  getLocation() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled!) {
      print("service disabled");
      _locationData = await Geolocator.requestPermission();
    } else {
      print("service  enabled");
    }

    _locationData = await Geolocator.checkPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _locationData = await Geolocator.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    curentPosition = await Geolocator.getCurrentPosition();

    print(
        "the latitudee and longitude iss ${curentPosition!.latitude} ${curentPosition!.latitude}");
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        curentPosition!.latitude, curentPosition!.longitude);
    latitude = curentPosition!.latitude.toString();
    longitude = curentPosition!.longitude.toString();

    geo.Placemark place = placemarks[0];
    currentAddress = "${place.locality},${place.country}";
    notifyListeners();
  }

//-------------to get weather details ----------------
  Future<void> getWeatherReport(String date) async {
    print("the latitude longitude and date iss $latitude, $longitude, $date");
    String uri =
        "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=$date&appid=bac97938dfcac7bb4def50d381e18bbd";
    try {
      var response = await Dio().post(uri,
          options: Options(headers: {
            "Content-Type": 'application/json',
          }));
      print("the response iss ${response.data}");

      weatherReport = WeatherDetailsModel.fromJson(response.data);
      notifyListeners();
    } on DioError catch (e) {
      debugPrint("hfghgg" + e.toString());
    }
  }
}

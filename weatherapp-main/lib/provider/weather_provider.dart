// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:weather_app_interviw/models/key_class.dart';
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
  bool tempChange = false;

  List cloud = [];
  List wind = [];
  List sun = [];
  List rain = [];

  changeTemprature(bool value) {
    tempChange = value;

    notifyListeners();
  }

  getLocationbyData() async {
    try {
      List<geo.Location> locations =
          await geo.locationFromAddress(locationController.text);
      latitude = locations[0].latitude.toString();
      longitude = locations[0].longitude.toString();
      currentAddress = locationController.text;
      notifyListeners();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(Keyclass.navKey.currentContext!)
          .showSnackBar(SnackBar(
        content: const Text("Something wrong in the location you entered",
            style: TextStyle(color: Color(0xFF8B0000))),
        backgroundColor: Color(0xFFFF9B9B),
        shape: Border.all(color: Color(0xFFD40000)),
        duration: Duration(seconds: 2),
      ));
    }
  }

  getLocation() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled!) {
      _locationData = await Geolocator.requestPermission();
    } else {}

    _locationData = await Geolocator.checkPermission();


    if (_locationData == LocationPermission.denied) {
      _locationData = await Geolocator.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    curentPosition = await Geolocator.getCurrentPosition();

    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        curentPosition!.latitude, curentPosition!.longitude);
    latitude = curentPosition!.latitude.toString();
    longitude = curentPosition!.longitude.toString();

    geo.Placemark place = placemarks[0];
    currentAddress = "${place.locality},${place.country}";

    notifyListeners();
  }

//-------------to get weather details ----------------
  Future<void> getWeatherReport(String date, BuildContext context) async {

    String uri =
        "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=$date&appid=bac97938dfcac7bb4def50d381e18bbd";
    try {
      var response = await Dio().post(uri,
          options: Options(headers: {
            "Content-Type": 'application/json',
          }));

      weatherReport = WeatherDetailsModel.fromJson(response.data);
      rain=[];
      cloud=[];
      wind=[];
      sun=[];
      for (int i = 0; i < weatherReport!.hourly!.length; i++) {
        cloud.add(weatherReport!.hourly![i].clouds ?? 0);
        wind.add(weatherReport!.hourly![i].windSpeed ?? 0);
        sun.add(weatherReport!.hourly![i].temp ?? 0);
        rain.add(weatherReport!.hourly![i].rain!=null?weatherReport!.hourly![i].rain?.the1H : 0);
      }

      print(rain);
      cloud.isNotEmpty ? cloud.sort() : debugPrint("there is no cloud");
      wind.isNotEmpty ? wind.sort() : debugPrint("there is no wind");
      sun.isNotEmpty ? sun.sort() : debugPrint("there is no sun");
      rain.isNotEmpty ? rain.sort() : debugPrint("there is no rain");
      notifyListeners();
    } on DioError catch (_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("There is some error in your internet connection",
            style: TextStyle(color: Color(0xFF8B0000))),
        backgroundColor: const Color(0xFFFF9B9B),
        shape: Border.all(color: const Color(0xFFD40000)),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}

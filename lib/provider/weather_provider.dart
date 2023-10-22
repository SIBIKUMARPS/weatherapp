

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_interviw/models/weather_model.dart';

class weatherProvider extends ChangeNotifier {
//-------------to get businessTrip Details in List Page ----------------
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

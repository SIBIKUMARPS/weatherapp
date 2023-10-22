import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_interviw/provider/weather_provider.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {


@override
  void initState() {

          Provider.of<weatherProvider>(context, listen: false).getLocation();

    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<weatherProvider>(
        builder: (context, pro, value) {
          return Container(
             child: Center(
               child: TextButton(
                  child: Text("Click Here", style: TextStyle(fontSize: 20),),
                 onPressed: () {
                    pro.getWeatherReport("latitude", "longitude");

                 },
                ),
             )

          );
        }
      ),
    );
  }
}

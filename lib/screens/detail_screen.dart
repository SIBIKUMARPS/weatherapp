import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_interviw/provider/weather_provider.dart';

class detailScreen extends StatefulWidget {
  const detailScreen({super.key});

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(

        children: [
          Consumer<weatherProvider>(builder: (context, pro, value) {
            print("pro.weatherReport ${pro.weatherReport}");

            if(pro.weatherReport!=null){
              return Container(

                child: Text(pro.weatherReport!.hourly![0].clouds.toString()),
              );
            }
            else{
              return Center(

                child:Container(
                    height: MediaQuery.of(context).size.height,
                  child: CircularProgressIndicator())
              );
            }

          })
        ],
      ),
    ));
  }
}

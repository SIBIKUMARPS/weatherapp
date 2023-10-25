import 'package:flutter/cupertino.dart';
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
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<weatherProvider>(builder: (context, pro, value) {
         

          if (pro.weatherReport != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                 const SizedBox( height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "DEGREE CELSIUS",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        CupertinoSwitch(
                          activeColor: Colors.black,
                          value: pro.tempChange,
                          trackColor: Colors.black12,
                          onChanged: (value) =>
                              pro.changeTemprature(value),
                        ),
                        const Text(
                          "FAHRENHEIT",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Image(
                    image: AssetImage(
                      'assets/images/sunwithcloud.png',
                    ),
                    height: 150,
                    width: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        pro.tempChange == false
                            ? " Temp: ${pro.weatherReport!.current!.temp.toString()} \u2103"
                            : "Temp: ${((pro.weatherReport!.current!.temp!) * (9 / 5) + 32).toStringAsFixed(2)} \u2109",
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                           decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow:const [
                          BoxShadow(
                              color: Colors.black, spreadRadius: 3),
                        ],
                          ),
                          height: size.height / 5,
                          width: size.width / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage(
                                  'assets/images/rain.png',
                                ),
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Min Rain: ${pro.rain.first.toString()}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Max Rain: ${pro.rain.last.toString()}",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        Container(
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow:const [
                              BoxShadow(
                                  color: Colors.black, spreadRadius: 3),
                            ],
                          ),
                          height: size.height / 5,
                          width: size.width / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage(
                                  'assets/images/sun.png',
                                ),
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Min Rain: ${pro.sun.first.toString()}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Max Rain: ${pro.sun.last.toString()}",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow:const [
                              BoxShadow(
                                  color: Colors.black, spreadRadius: 3),
                            ],
                          ),
                          height: size.height / 5,
                          width: size.width / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage(
                                  'assets/images/wind.png',
                                ),
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Min Rain: ${pro.wind.first.toString()}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Max Rain: ${pro.wind.last.toString()}",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow:const [
                              BoxShadow(
                                  color: Colors.black, spreadRadius: 3),
                            ],
                          ),
                          height: size.height / 5,
                          width: size.width / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage(
                                  'assets/images/cloud.png',
                                ),
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Min Rain: ${pro.cloud.first.toString()}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Max Rain: ${pro.cloud.last.toString()}",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - 50,
                    width: MediaQuery.of(context).size.width - 50,
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        )))));
          }
        }),
      ),
    ));
  }
}

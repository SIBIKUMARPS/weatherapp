import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_interviw/provider/weather_provider.dart';
import 'package:weather_app_interviw/screens/detail_screen.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  // DateTime date0 = DateTime.now();
  // DateTime date1 = DateTime.now().subtract(const Duration(days: 1));
  // DateTime date2 = DateTime.now().subtract(const Duration(days: 2));
  // DateTime date3 = DateTime.now().subtract(const Duration(days: 3));
  // DateTime date4 = DateTime.now().subtract(const Duration(days: 4));

  // List<DateTime> dateList = [date0, date1, date2, date3, date4];
  final dates = List<DateTime>.generate(
      60,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: -i)));

  @override
  void initState() {
    Provider.of<weatherProvider>(context, listen: false).getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<weatherProvider>(context, listen: false).locationController;

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Consumer<weatherProvider>(builder: (context, pro, value) {
                return TextFormField(
                  cursorColor: Colors.black,
                  controller: pro.locationController,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            pro.getLocationbyData();
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Location"),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child:
                    Consumer<weatherProvider>(builder: (context, pro, value) {
                  return Text(
                    pro.currentAddress == null
                        ? "Please slect the place or turn on the location"
                        : "The curent location is \n ${pro.currentAddress}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ),
              Consumer<weatherProvider>(builder: (context, pro, value) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          if (pro.currentAddress != null) {
                            if (index == 0) {
                              int time =
                                  Timestamp.fromDate(dates[index]).seconds -
                                      3700;
                              pro.getWeatherReport(time.toString(), context);
                            } else {
                              pro.getWeatherReport(
                                  Timestamp.fromDate(dates[index])
                                      .seconds
                                      .toString(),
                                  context);
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const detailScreen()));
                          } else {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Please wait'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'check your network conection and click after 1 minutes.'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.date_range),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  print('Yay!');
                                },
                              ),
                              Text(DateFormat('yyyy-MM-dd')
                                  .format(dates[index])),
                              const Expanded(child: SizedBox()),
                              const Icon(
                                Icons.arrow_right,
                                size: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ),
      )),
    );
  }
}

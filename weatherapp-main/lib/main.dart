import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_interviw/models/key_class.dart';
import 'package:weather_app_interviw/provider/weather_provider.dart';
import 'package:weather_app_interviw/screens/home_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => weatherProvider())
      ],
      child: MaterialApp(
        navigatorKey: Keyclass.navKey,
        debugShowCheckedModeBanner: false,
        home: const home_screen(),
      ),
    );
  }
}

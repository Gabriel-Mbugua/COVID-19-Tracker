import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:covid19tracker/app/services/connectivity_service.dart';
import 'package:covid19tracker/screens/HomePage.dart';
import 'enums/connectivity_status.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<ConnectivityStatus>(
      create: (context) => ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
        title: 'COVID-19 Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xff1a1b25),
          primaryColorLight: Color(0xff242535),
//        primarySwatch: Colors.green,
          accentColor: Colors.green,
//        iconTheme: IconThemeData(size: 50),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xff1a1b25),
          primaryColorLight: Color(0xff242535),
          accentColor: Colors.green,
        ),
        home: MyHomePage(),
      ),
    );
  }
}



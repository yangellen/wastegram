import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:wastegram/screens/list_screen.dart';

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wastegram",
      theme: ThemeData(
          primaryColor: Colors.indigo[300],
          accentColor: Colors.indigo[300],
          scaffoldBackgroundColor: Colors.indigo,
          hintColor: Colors.indigo[50],
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      navigatorObservers: <NavigatorObserver>[observer],
      home: ListScreen(analytics: analytics, observer: observer),
    );
  }
}

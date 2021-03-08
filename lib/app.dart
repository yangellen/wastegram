import 'package:flutter/material.dart';
import 'package:wastegram/screens/list_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wastegram",
      theme: ThemeData(
          primaryColor: Colors.indigo[300], accentColor: Colors.indigo[300]),
      home: ListScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wastegram/screens/list_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wastegram",
      home: ListScreen(),
    );
  }
}

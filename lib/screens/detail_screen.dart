import 'package:flutter/material.dart';

class DetialScreen extends StatelessWidget {
  final date;
  final imageUrl;
  final quantity;
  final latitude;
  final longitude;

  DetialScreen(
      {this.date, this.imageUrl, this.quantity, this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wastegram"),
        centerTitle: true,
      ),
      body: displayDetail(),
    );
  }

  //display journal detail
  Widget displayDetail() {
    return ListView(
      children: [
        Container(
          child: Center(
            child: Text(date),
          ),
        ),
        Container(
          child: Center(
            child: Text(imageUrl),
          ),
        ),
        Container(
          child: Center(
            child: Text('$quantity items'),
          ),
        ),
        Container(
          child: Center(
            child: Text('Location: ($latitude, $longitude)'),
          ),
        ),
      ],
    );
  }
}

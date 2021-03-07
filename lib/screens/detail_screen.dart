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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Center(
              child: Text(
                date,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            child: Center(
              child: Image(
                image: NetworkImage('$imageUrl'),
                loadingBuilder: (context, child, progress) {
                  return progress == null ? child : CircularProgressIndicator();
                },
                height: 400,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Text('$quantity items',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Text('Location: ($latitude, $longitude)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }
}

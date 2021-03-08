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
        textContainer(date, 12.0),
        imageContainer(),
        textContainer('$quantity items', 8.0),
        textContainer('Location: ($latitude, $longitude)', 8.0),
      ],
    );
  }

  //create container with image of waste item
  Widget imageContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        child: Center(
          child: Semantics(
            label: 'Image of the waste item',
            image: true,
            readOnly: true,
            child: Image(
              image: NetworkImage('$imageUrl'),
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : Semantics(
                        label: 'Loading picture',
                        child: CircularProgressIndicator());
              },
              height: 400,
            ),
          ),
        ),
      ),
    );
  }

  //create container with text
  Widget textContainer(String text, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        child: Center(
          child: Semantics(
            label: text,
            readOnly: true,
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

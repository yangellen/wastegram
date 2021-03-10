import 'package:flutter/material.dart';

import 'package:wastegram/model/food_waste_post.dart';

class DetialScreen extends StatelessWidget {
  final FoodWastePost post;

  DetialScreen({this.post});

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
        textContainer(post.date, 12.0),
        imageContainer(),
        textContainer('${post.quantity.toString()} items', 8.0),
        textContainer(
            'Location: (${post.latitude.toString()}, ${post.longitude.toString()})',
            8.0),
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
              image: NetworkImage('${post.imageUrl}'),
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

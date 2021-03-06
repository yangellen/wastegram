import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File image;

  final picker = ImagePicker();

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      getImage();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(image),
            SizedBox(height: 20),
            RaisedButton(child: Text('Post it'), onPressed: () {})
          ],
        ),
      );
    }
  }
}

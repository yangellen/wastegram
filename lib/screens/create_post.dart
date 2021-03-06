import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:wastegram/model/food_waste_post.dart';
import 'package:wastegram/screens/list_screen.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final formKey = GlobalKey<FormState>(); //Global key
  final newPost = FoodWastePost(); //use to collect data

  File image;

  final picker = ImagePicker();

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);

    //upload image to firebase cloud storage
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(Path.basename(image.path));
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    newPost.imageUrl = await storageReference.getDownloadURL();
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
      return Scaffold(
        appBar: AppBar(
          title: Text('New Post'),
          centerTitle: true,
        ),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                Image.file(image),
                createTextField(),
                ElevatedButton.icon(
                    onPressed: () => validateAndUpload(),
                    icon: Icon(Icons.cloud_upload),
                    label: Text("Submit Post"))
              ]),
            )),
      );
    }
  }

  Widget createTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: InputDecoration(
            labelText: "Number of wasted item", border: OutlineInputBorder()),
        onSaved: (value) => saveUserInput(value),
        validator: (value) => validateInput(value),
      ),
    );
  }

  //save user input
  void saveUserInput(String userInput) {
    newPost.quantity = int.parse(userInput);
  }

  //function to validate form
  String validateInput(String userInput) {
    if (userInput.isEmpty) {
      return 'Please enter number of wasted items';
    }
    return null;
  }

  //valide and save data when user hit save
  void validateAndUpload() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save(); //if the form is  valid, save data

      //add date
      //add URL
      //Add location
      //upload
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ListScreen()));
    }
  }
}

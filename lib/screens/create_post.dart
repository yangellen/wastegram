import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wastegram/model/food_waste_post.dart';
import 'package:wastegram/screens/list_screen.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  //variable for form
  final formKey = GlobalKey<FormState>(); //Global key
  final newPost = FoodWastePost(); //use to collect data

  //varialbe for image
  File image;
  final picker = ImagePicker();

  //vaiable used for location
  LocationData locationData;
  var locationService = Location();

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

  //take picture and uploade in firebase storeage and save the url
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

  //text form to get user input
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
      addFormateDate();

      //Add location
      try {
        var _serviceEnabled = await locationService.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await locationService.requestService();
          if (!_serviceEnabled) {
            print('Failed to enable service. Returning.');
            return;
          }
        }

        var _permissionGranted = await locationService.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await locationService.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            print('Location service permission not granted. Returning.');
          }
        }

        locationData = await locationService.getLocation();
      } on PlatformException catch (e) {
        print('Error: ${e.toString()}, code: ${e.code}');
        locationData = null;
      }
      locationData = await locationService.getLocation();

      //store in FoodWastePost object
      newPost.latitude = locationData.latitude;
      newPost.longitude = locationData.longitude;

      //upload
      FirebaseFirestore.instance.collection('posts').add({
        'date': newPost.date,
        'imageUrl': newPost.imageUrl,
        'latitude': newPost.latitude,
        'longitude': newPost.longitude,
        'quantity': newPost.quantity
      });

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ListScreen()));
    }
  }

  //add and formate datetime
  void addFormateDate() {
    final date = DateTime.now();
    final DateFormat formatter = DateFormat.yMMMMEEEEd('en-us');
    newPost.date = formatter.format(date);
  }
}

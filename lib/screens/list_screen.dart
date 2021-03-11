import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wastegram/model/food_waste_post.dart';
import 'package:wastegram/screens/create_post.dart';
import 'package:wastegram/screens/detail_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasData &&
            snapshots.data.documents != 0 &&
            snapshots.data.documents.length > 0) {
          var totalWaste = 0;
          for (var doc in snapshots.data.documents) {
            totalWaste += doc['quantity'];
          }

          return generalWidget(
              'Wastegram - $totalWaste', postWidget(snapshots));
        } else {
          return generalWidget("Wastegram", progressWidget());
        }
      },
    );
  } //build

  //take user to create post when click on camera icon
  void moveToCreatePost() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreatePost()));
  }

  //widget to indicate there is no post
  Widget progressWidget() {
    return Semantics(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 38.0),
              child: CircularProgressIndicator(),
            ),
            Text('No post yet, click to create new post')
          ],
        ),
      ),
      label: 'Loading Progress Indicator, No post yet',
      readOnly: true,
    );
  }

  //widget that return list of posts
  Widget postWidget(var snapshots) {
    return ListView.builder(
        key: Key('post_list'), // use for integration test
        itemCount: snapshots.data.documents.length,
        itemBuilder: (context, index) {
          var post = snapshots.data.documents[index];
          FoodWastePost postObj = FoodWastePost();
          postObj.date = post['date'];
          postObj.imageUrl = post['imageUrl'];
          postObj.quantity = post['quantity'];
          postObj.latitude = post['latitude'];
          postObj.longitude = post['longitude'];

          return ListTile(
            leading: Semantics(
              child: Text(
                post['date'],
                key: Key('item_${index}_text'),
              ),
              label: 'Date : ${post['date']}',
              onTapHint: 'Take user to post detail',
            ),
            trailing: Semantics(
                child: Text(post['quantity'].toString()),
                label: 'Quantity : ${post['quantity'].toString()}',
                onTapHint: 'Take user to post detail'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetialScreen(
                        post: postObj,
                      )));
            },
          );
        });
  }

  //general scaffold widget that will take tilte and body as parameter
  Widget generalWidget(String title, Widget body) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: Semantics(
        child: cameraButton(),
        button: true,
        enabled: true,
        label: 'A button to take a picture of the waste item',
        onTapHint: 'Take a picture of the waste item',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //button allow users to take pictue and tkae user to post form when pressed
  Widget cameraButton() {
    return FloatingActionButton(
      onPressed: () => moveToCreatePost(),
      tooltip: 'Create New Post',
      child: const Icon(Icons.camera_alt, color: Colors.white),
    );
  }
}

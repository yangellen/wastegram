import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasData &&
            snapshots.data.documents != 0 &&
            snapshots.data.documents.length > 0) {
          var totalWaste = 0;
          for (var doc in snapshots.data.documents) {
            totalWaste += doc['quantity'];
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Wastegram - $totalWaste'),
              centerTitle: true,
            ),
            body: ListView.builder(
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  var post = snapshots.data.documents[index];
                  return ListTile(
                    leading: Text(post['date']),
                    trailing: Text(post['quantity'].toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetialScreen(
                                date: post['date'],
                                imageUrl: post['imageUrl'],
                                quantity: post['quantity'].toString(),
                                latitude: post['latitude'].toString(),
                                longitude: post['longitude'].toString(),
                              )));
                    },
                  );
                }),
            floatingActionButton: FloatingActionButton(
                onPressed: () => moveToCreatePost(),
                tooltip: 'Create New Post',
                child: const Icon(Icons.camera_alt)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Wastegram'),
              centerTitle: true,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => moveToCreatePost(),
                tooltip: 'Create New Post',
                child: const Icon(Icons.camera_alt)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
      },
    );
  } //build

  void moveToCreatePost() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreatePost()));
  }
}

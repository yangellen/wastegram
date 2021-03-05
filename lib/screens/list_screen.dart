import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          return Scaffold(
            appBar: AppBar(
              title: Text('Wastegram'),
              centerTitle: true,
            ),
            body: ListView.builder(
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  var post = snapshots.data.documents[index];
                  return ListTile(
                    title: Text(post['quantity'].toString()),
                  );
                }),
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
          );
        }
      },
    );
  }
}

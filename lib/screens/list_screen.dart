import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastegram/screens/detail_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int totalWaste = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wastegram - $totalWaste'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData &&
              snapshots.data.documents != 0 &&
              snapshots.data.documents.length > 0) {
            totalWaste = 0;
            return ListView.builder(
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  var post = snapshots.data.documents[index];
                  totalWaste += post['quantity'];
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
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

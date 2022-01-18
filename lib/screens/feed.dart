import 'package:flutter/material.dart';
import 'package:loginsignup/layout/imports.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feed extends StatefulWidget {
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Stream<QuerySnapshot<Map<String, dynamic>>> firestore =
      FirebaseFirestore.instance.collection('Posts').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerwidget(),
      appBar: Appbarwidget('Feed'),
      bottomSheet: Footerwidget(),
      body: StreamBuilder(
          stream: firestore,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return Text((snapshot.data! as QuerySnapshot)
                  .docs[0]['title']
                  .toString());
            }
            if (!snapshot.hasData) {
              return Text(snapshot.data.toString());
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Post('Egycon', 'post1.png'),
                    Post('Recruitment', 'post2.png'),
                    Post('gaming festival', 'post1.png'),
                    Post('season end', 'post2.png')
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Post extends StatelessWidget {
  String? title;
  String? image;
  Post(String title, String image) {
    this.title = title;
    this.image = image;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  children: [
                    Text(
                      title!,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/' + image!,
                      fit: BoxFit.fitWidth,
                    ),
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
                      style: TextStyle(fontSize: 15),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width - 10,
        decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
        margin: EdgeInsets.only(top: 10),
      ),
    );
  }
}

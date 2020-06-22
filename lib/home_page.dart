import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitr/announcement_tile.dart';
import 'package:iiitr/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text(
              "NO",
                  style: TextStyle(fontSize: 15),
                ),
          ),
          SizedBox(height: 40),
          new GestureDetector(
            onTap: () => exit(0),
            child: Text(
              "YES",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'Home',
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('announcement')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<AnnouncementTile> tiles = [];
              var announcements = snap.data.documents;
              for (var announcement in announcements) {
                var tile = AnnouncementTile(
                  heading: announcement['heading'],
                  details: announcement['details'],
                );
                tiles.add(tile);
              }
              return ListView(
                children: tiles,
              );
            }),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:iiitr/announcement_tile.dart';
import 'package:iiitr/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
 static  const String id = 'HomeScreen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'Home',
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('announcement').orderBy('time',descending: true).snapshots(),
          builder: (context, snap) {
            if(!snap.hasData)
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            List<AnnouncementTile> tiles = [];
            var announcements =  snap.data.documents;
            for(var announcement in announcements)
              {
                var tile = AnnouncementTile(
                  heading: announcement['heading'],
                  details: announcement['details'],
                );
                tiles.add(tile);
              }
            return ListView(
              children: tiles,
            );
          }
            ),
    );
        }

  }


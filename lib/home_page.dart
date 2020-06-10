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
  void initState() {
    getAnnouncementData();
    super.initState();
  }
  
  QuerySnapshot snap;
  Future<void> getAnnouncementData()async {
       snap = await Firestore.instance.collection('announcement').orderBy('time',descending: true).getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          'IIIT Dashboard',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getAnnouncementData();
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
              children: snap != null ? snap.documents.map((doc) => AnnouncementTile(
                heading: doc['heading'],
                details: doc['details'],
              )).toList() : [SnackBar(content: Text('unable to refresh'))],
            ),
      ),
    );
        }

  }


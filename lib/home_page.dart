import 'package:flutter/material.dart';
//import 'package:iiitr/course_schedule.dart';
import 'package:iiitr/my_drawer.dart';
//mport 'drawer_items.dart';

class HomePage extends StatefulWidget {
 static  const String id = 'HomeScreen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iiitr/course_schedule.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        CourseSchedule.id: (context) => CourseSchedule(),
      },
      //home: HomePage(),
    );
  }
}


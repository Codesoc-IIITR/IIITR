import 'package:flutter/material.dart';
import 'package:iiitr/course_schedule.dart';
import 'package:iiitr/mess_menu_screen.dart';
import 'home_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: SplashScreen.id,
     // initialRoute: MessMenuScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomePage.id: (context) => HomePage(),
        CourseSchedule.id: (context) => CourseSchedule(),
        MessMenuScreen.id: (context) => MessMenuScreen(),
      },
      //home: HomePage(),
    );
  }
}


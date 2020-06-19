import 'package:flutter/material.dart';
import 'package:iiitr/bus_schedule.dart';
import 'package:iiitr/course_schedule.dart';
import 'package:iiitr/mess_menu_screen.dart';
import 'home_page.dart';
import 'splash_screen.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter/services.dart';

void main() {
  GoogleMap.init("AIzaSyDqvvYdQRi3gLH8mXqOQuGIXfuv5dDnT38");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
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
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomePage.id: (context) => HomePage(),
        CourseSchedule.id: (context) => CourseSchedule(),
        MessMenuScreen.id: (context) => MessMenuScreen(),
        BusSchedule.id: (context) => BusSchedule(),
      },
    );
  }
}


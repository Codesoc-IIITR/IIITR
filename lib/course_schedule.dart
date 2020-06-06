import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

//void main() => runApp(new MyApp());

class CardItemModel {
  String cardTitle;
  CardItemModel(this.cardTitle);
}
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Course',
//      theme: new ThemeData(
//        primarySwatch: Colors.blueGrey,
//      ),
//      home: new MyHomePage(),
//      debugShowCheckedModeBanner: false,
//    );
//  }
//}

class CourseSchedule extends StatefulWidget {
  static const String id = 'CourseSchedule';
  @override
  _CourseScheduleState createState() => new _CourseScheduleState();
}
class _CourseScheduleState extends State<CourseSchedule> {
  int _index = 0;
  var cardsList = [CardItemModel("Monday"),CardItemModel("Tuesday"),CardItemModel("Wednesday"),CardItemModel("Thursday"),CardItemModel("Friday")];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     // backgroundColor:Colors.black,
      appBar: AppBar(title: new Text("Course Schedule", style: TextStyle(fontSize: 25.0),),
       // backgroundColor:Colors.black,
        centerTitle: true,),
      body: Center(
        child: SizedBox(
          height: 550, // card height
          child: PageView.builder(
            itemCount: 5,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: Card(
              //    color: Colors.blueGrey[900],
                  elevation: 7,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child:FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      speed: 1000,
                      onFlipDone: (status) {
                        print(status);
                      },
                    front: Center(child:Text("${cardsList[i].cardTitle}", style: TextStyle(fontSize: 38.0,color: Colors.white)),),
                    back: Center(child:Text("Schedule", style: TextStyle(fontSize: 38.0,color: Colors.white)),)
                    ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

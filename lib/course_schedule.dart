import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:iiitr/my_drawer.dart';
import 'screen_arguments.dart';
import 'package:auto_size_text/auto_size_text.dart';

//void main() => runApp(new MyApp());
class CardItemModel {
  String cardTitle;
  CardItemModel(this.cardTitle);
}

class GenerateLines extends StatelessWidget {
  final lines;
  const GenerateLines({
    Key key,
    this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            4,
            (index) => Container(
                  height: 2,
                  width: lines[index],
                  color: Color(0xffd0d2d8),
                  margin: EdgeInsets.symmetric(vertical: 14.0),
                )));
  }
}

class CourseSchedule extends StatefulWidget {
  static const String id = 'CourseSchedule';
  @override
  _CourseScheduleState createState() => new _CourseScheduleState();
}

class _CourseScheduleState extends State<CourseSchedule> {
  var className = [];
  var time = [];
  int classNum = 0;

  int _index = 0;
  var cardsList = [
    CardItemModel("Monday"),
    CardItemModel("Tuesday"),
    CardItemModel("Wednesday"),
    CardItemModel("Thursday"),
    CardItemModel("Friday")
  ];

  @override
  Widget build(BuildContext context) {
    final ScheduleYearScreenArguments args =  ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      drawer: MyDrawer(),
      // backgroundColor:Colors.black,
      appBar: AppBar(
        title: new Text(
          "Course Schedule",
          style: TextStyle(fontSize: 25.0),
        ),
        // backgroundColor:Colors.black,
        centerTitle: true,
      ),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('Course Schedule')
                        .document('${args.selectedYear}')
                        .collection('${cardsList[i].cardTitle}')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var lectureNames = snapshot.data.documents;

                      for (var lectureName in lectureNames) {
                        if (lectureName.documentID == 'Classes') {
                          className = lectureName['className'];
                          time = lectureName['Time'];
                        }
                      }

                      return FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        speed: 1000,
                        onFlipDone: (status) {
                          print(status);
                        },
                        front: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("${cardsList[i].cardTitle}",
                                style: TextStyle(
                                    fontSize: 38.0, color: Colors.white)),
                            SizedBox(height: 50.0,),
                            Text("${args.selectedYear}"),
                          ],
                        ),
                        back: ListView.builder(
                          itemCount: className.length !=0 ? className.length : 1 ,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                          child: GenerateLines(
                                        lines: [10.0, 20.0, 30.0, 10.0],
                                      )),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              bottomLeft: Radius.circular(8.0),
                                            )),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                            top: 8.0,
                                          ),
                                          margin: EdgeInsets.only(left: 4.0),
                                          color: Colors.black38,
                                          child: SafeArea(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('${className.length==0 ? "" : time[index]}'),
                                                SizedBox(height: 8.0),
                                                AutoSizeText(
                                                  '${className.length==0 ? "Nothing Scheduled for ${cardsList[i].cardTitle}" : className[index]}',
                                                  style:
                                                      TextStyle(fontSize: 22.0),
                                                  maxLines: 2,
                                                  maxFontSize: 22,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
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


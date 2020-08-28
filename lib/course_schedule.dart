import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iiitr/main.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:iiitr/my_drawer.dart';
import 'screen_arguments.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:iiitr/home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

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
            3,
            (index) => Container(
                  height: 2,
                  width: lines[index],
                  color: Color(0xffd0d2d8),
                  margin: EdgeInsets.symmetric(vertical: 14.0),
                )));
  }
}

class BuildedSwitch extends StatefulWidget {
  final int switchNumber1;
  final int switchNumber2;
  final bool finalSwitchState;

  //final VoidCallback callback;

  const BuildedSwitch(
      {Key key, this.switchNumber1, this.switchNumber2, this.finalSwitchState})
      : super(key: key);

  @override
  _BuildedSwitchState createState() => _BuildedSwitchState();
}

class _BuildedSwitchState extends State<BuildedSwitch> {
  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  @override
  void initState() {
    super.initState();
    _requestIOSPermissions();
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  addBoolToSF(bool select, int numb1, int numb2) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    await prefs1.setBool('boolValue$numb1$numb2', select);
  }

  Future<bool> getBoolValuesSF(int numb1, int numb2) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return bool
    if (widget.finalSwitchState == false) {
      return prefs1.getBool('boolValue$numb1$numb2') == null
          ? false
          : prefs1.getBool('boolValue$numb1$numb2');
    } else if (widget.finalSwitchState == true) {
      await prefs1.remove('boolValue$numb1$numb2');
      return true;
    }
  }

  var className = List<List<dynamic>>();
  var time = List<List<dynamic>>();
  var notificationTime = List<List<dynamic>>();

  int today = DateTime.now().weekday - 1;

  @override
  Widget build(BuildContext context) {
    final ScheduleYearScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Course Schedule')
            .document('${args.selectedYear}')
            .collection('Days')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var lectureNames = snapshot.data.documents;

          for (int i = 0; i < 7; i++) {
            for (var lectureName in lectureNames) {
              if (lectureName.documentID == '${days[i]}') {
                className.add(lectureName['className']);
                notificationTime.add(lectureName['notificationTime']);
                time.add(lectureName['Time']);
              }
            }
          }

          if (widget.finalSwitchState == true) {
            for (int i = 15, k = 0; i < 20 && k < 5; i++, k++) {
              for (int j = 0; j < 3; j++) {
                _showWeeklyAtDayAndTime((i * 3) + j, j, notificationTime[k],
                    className[k], time[k], k + 1);
                _cancelNotification((k * 3) + j);
              }
            }
          } else if (widget.finalSwitchState == false) {
            for (int i = 15; i < 20; i++) {
              for (int j = 0; j < 3; j++) {
                _cancelNotification((i * 3) + j);
                }
              }
            }

          //forcedNotifications();

          return FutureBuilder<bool>(
              future:
                  getBoolValuesSF(widget.switchNumber1, widget.switchNumber2),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return Switch(
                    value: snapshot.data,
                    onChanged: (bool state) {
                      setState(() {
                        addBoolToSF(
                            state, widget.switchNumber1, widget.switchNumber2);
                      });

                      if (snapshot.data == false &&
                          widget.finalSwitchState == true) {
                        _showWeeklyAtDayAndTime(
                            (widget.switchNumber1 * 3) + widget.switchNumber2,
                            widget.switchNumber2,
                            notificationTime[widget.switchNumber1],
                            className[widget.switchNumber1],
                            time[widget.switchNumber1],
                            widget.switchNumber1 + 1);
                      } else if (snapshot.data == false &&
                          widget.finalSwitchState == false) {
                        _showWeeklyAtDayAndTime(
                            (widget.switchNumber1 * 3) + widget.switchNumber2,
                            widget.switchNumber2,
                            notificationTime[widget.switchNumber1],
                            className[widget.switchNumber1],
                            time[widget.switchNumber1],
                            widget.switchNumber1 + 1);
                        toast(
                            'You will get Notified 10-15 mins before ${className[widget.switchNumber1][widget.switchNumber2]} class');
                      } else if (snapshot.data == true &&
                          widget.finalSwitchState == true) {
                        _cancelNotification(
                            (widget.switchNumber1 * 3) + widget.switchNumber2);
                      } else if (snapshot.data == true &&
                          widget.finalSwitchState == false) {
                        _cancelNotification(
                            (widget.switchNumber1 * 3) + widget.switchNumber2);
                        toast(
                            'You just Disabled Notification for ${className[widget.switchNumber1][widget.switchNumber2]} class');
                      }

                      print(
                          'Current State of SWITCH IS: ${widget.switchNumber2} and ${widget.switchNumber1} and $today and ${notificationTime[4]} and  ${int.parse('${notificationTime[today][widget.switchNumber2].substring(0, 2)}')} and ${int.parse('${notificationTime[today][widget.switchNumber2].substring(3, 5)}')}');
                    },
                  );
                } else {
                  return Container();
                }
              });
        });
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
  var notificationTime = [];

  int _index = 0;
  var cardsList = [
    CardItemModel("Monday"),
    CardItemModel("Tuesday"),
    CardItemModel("Wednesday"),
    CardItemModel("Thursday"),
    CardItemModel("Friday")
  ];

  Future<bool> backPressed() async {
    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      ModalRoute.withName(HomePage.id),
    );
  }

  static List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  addBoolToSF(bool select) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isSelected', select);
  }

  Future<bool> getBoolValuesSF() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Return bool
    return preferences.getBool('isSelected') ?? false;
  }

  bool rollingSwitchState = false;

  @override
  Widget build(BuildContext context) {
    final ScheduleYearScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: backPressed,
      child: new Scaffold(
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('Course Schedule')
                        .document('${args.selectedYear}')
                        .collection('Days')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var lectureNames = snapshot.data.documents;

                      for (var lectureName in lectureNames) {
                        if (lectureName.documentID ==
                            '${days[DateTime.now().weekday - 1]}') {
                          className = lectureName['className'];
                          notificationTime = lectureName['notificationTime'];
                          time = lectureName['Time'];
                        }
                      }
                      return FutureBuilder<bool>(
                          future: getBoolValuesSF(),
                          builder: (context, AsyncSnapshot<bool> snapshot) {
                            if (snapshot.hasData &&
                                args.selectedYear == 'First Year') {
                              return Row(
                                children: <Widget>[
                                  /*SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          _checkPendingNotificationRequests(
                                              context);
                                        });
                                      },
                                      child: Text("Pending Notifications"),
                                      color: Colors.black,
                                      textColor: Colors.white,
                                    ),
                                  ),*/
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  LiteRollingSwitch(
//initial value
                                    value: snapshot.data,
                                    textOn: 'All\nEnabled',
                                    textOff: 'Enable\nby Choice',
                                    colorOn: Colors.greenAccent[700],
                                    colorOff: Colors.redAccent[700],
                                    animationDuration: Duration(seconds: 1),
                                    iconOn: Icons.notifications_active,
                                    iconOff: Icons.notifications,
                                    textSize: 17.0,
                                    onChanged: (bool state) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          rollingSwitchState = state;
                                          addBoolToSF(state);
                                          if (state == true) {
                                            toast(
                                                'Notifications are Enabled for All Classes Scheduled');
                                          } else if (state == false) {
                                            toast(
                                                'Enable by Choice is Enabled for Notifications');
                                          }
                                        });
                                      });
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
            ),
            Center(
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.7, // card height
                child: PageView.builder(
                  itemCount: 5,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
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
                              .collection('Days')
                              .snapshots(),
                          //cardsList[i].cardTitle
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            var lectureNames = snapshot.data.documents;

                            for (var lectureName in lectureNames) {
                              if (lectureName.documentID ==
                                  '${cardsList[i].cardTitle}') {
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
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Text("${args.selectedYear}"),
                                ],
                              ),
                              back: ListView.builder(
                                itemCount: className.length != 0
                                    ? className.length
                                    : 1,
                                padding: const EdgeInsets.all(8),
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Card(
                                      elevation: 7,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                    child: GenerateLines(
                                                  lines: [10.0, 30.0, 20.0],
                                                )),
                                                BuildedSwitch(
                                                  switchNumber1: i,
                                                  switchNumber2: index,
                                                  finalSwitchState:
                                                      rollingSwitchState,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8.0),
                                                    bottomLeft:
                                                        Radius.circular(8.0),
                                                  )),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  left: 16.0,
                                                  top: 8.0,
                                                ),
                                                margin:
                                                    EdgeInsets.only(left: 4.0),
                                                color: Colors.black38,
                                                child: SafeArea(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                          '${className.length == 0 ? "" : time[index]}'),
                                                      SizedBox(height: 8.0),
                                                      AutoSizeText(
                                                        '${className.length == 0 ? "Nothing Scheduled for ${cardsList[i].cardTitle}" : className[index]}',
                                                        style: TextStyle(
                                                            fontSize: 22.0),
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
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  SecondScreen(this.payload);

  final String payload;

  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen with payload: ${(_payload ?? '')}'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

Future<void> _showWeeklyAtDayAndTime(int notificationID, int itemNumber,
    List list, List className, List time, int day) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show weekly channel id',
      'show weekly channel name',
      'show weekly description',
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true));
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      notificationID,
      'Scheduled Class Alert',
      'You have ${className[itemNumber]} class Scheduled between ${time[itemNumber]} ',
      Day.values[day],
      Time(int.parse('${list[itemNumber].substring(0, 2)}'),
          int.parse('${list[itemNumber].substring(3, 5)}'), 00),
      platformChannelSpecifics);
}

Future<void> _checkPendingNotificationRequests(context) async {
  var pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
            '${pendingNotificationRequests.length} pending notification requests'),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}


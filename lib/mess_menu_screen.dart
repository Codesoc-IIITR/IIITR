import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiitr/my_drawer.dart';


class MessMenuScreen extends StatefulWidget {
  static const String id = 'MessMenuScreen';

  @override
  _MessMenuScreenState createState() => _MessMenuScreenState();
}

class _MessMenuScreenState extends State<MessMenuScreen> {

  static List<String> days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];
  String dropDownValue = days[DateTime.now().weekday - 1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          DropdownButton(
            underline: Container(
              height: 0.0,
            ),
            value: dropDownValue,
            onChanged: (newValue){
              setState(() {
                dropDownValue = newValue;
              });
            },
            items: days.map((String day){
              return DropdownMenuItem<String>(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 15.0, 0.0, 8.0),
                  child: Text(day),
                ),
                value: day,
              );
            }).toList(),

          ),
        ],
        title: Text(
          'Mess Menu'
        ),

      ),
        body: PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text('Breakfast'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text('Lunch'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text('Snacks'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text('Dinner'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
//      body: ListView(
//        scrollDirection: Axis.horizontal,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 100.0),
//            child: Card(
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(25.0),
//              ),
//              child: Padding(
//                padding: const EdgeInsets.all(100.0),
//                child: Center(child: Text('Breakfast')),
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 100.0),
//            child: Card(
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(25.0),
//              ),
//              child: Padding(
//                padding: const EdgeInsets.all(100.0),
//                child: Center(child: Text('Lunch')),
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 100.0),
//            child: Card(
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(25.0),
//              ),
//              child: Padding(
//                padding: const EdgeInsets.all(100.0),
//                child: Center(child: Text('Snacks')),
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 100.0),
//            child: Card(
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(25.0),
//              ),
//              child: Padding(
//                padding: const EdgeInsets.all(100.0),
//                child: Center(child: Text('Dinner')),
//              ),
//            ),
//          ),
//        ],
//      ),
    );
  }
}

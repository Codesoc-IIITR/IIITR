import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiitr/screen_arguments.dart';
import 'package:iiitr/my_drawer.dart';

import 'menu_text_widget.dart';


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
  Map<String,dynamic>  breakfast;
  Map<String,dynamic> lunch;
  Map<String,dynamic> dinner;
  Map<String,dynamic> snacks;
  String breakfastExtras;
  String lunchExtras;
  String snacksExtras;
  String dinnerExtras;
  @override
  Widget build(BuildContext context) {
    final MessMenuScreenArguments args =  ModalRoute.of(context).settings.arguments;
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
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('${args.selectedMess}').document('$dropDownValue').collection('meals').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var meals = snapshot.data.documents;
            for (var meal in meals) {
              if (meal.documentID == 'breakfast') {
                breakfast = meal['menu'];
                breakfastExtras = meal['extras'];
              } else if (meal.documentID == 'lunch') {
                lunch = meal['menu'];
                lunchExtras = meal['extras'];
              } else if (meal.documentID == 'snacks') {
                snacks = meal['menu'];
                snacksExtras = meal['extras'];
              } else if (meal.documentID == 'dinner') {
                dinner = meal['menu'];
                dinnerExtras = meal['extras'];
              }
            }
            List<MenuTextWidget> breakfastItems = [];
            List<MenuTextWidget> lunchItems = [];
            List<MenuTextWidget> snacksItems = [];
            List<MenuTextWidget> dinnerItems = [];
           try
          {

            breakfast.forEach((key, value) => breakfastItems.add(MenuTextWidget(value: value)));

            lunch.forEach((key, value) => lunchItems.add(MenuTextWidget(value: value)));

            snacks.forEach((key, value) => snacksItems.add(MenuTextWidget(value: value)));

            dinner.forEach((key, value) => dinnerItems.add(MenuTextWidget(value: value)));
          }
          catch(e)
            {
              print(e.toString());
            }

            return PageView(
              // scrollDirection: Axis.vertical,
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text('Breakfast'),
                                SizedBox(height: 10.0),
                                Expanded(
                                  child: ListView(
                                    children: breakfastItems,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text('Extras'),
                                SizedBox(height: 10.0),
                                MenuTextWidget(value: breakfastExtras),
                              ],
                            ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text('Lunch'),
                                SizedBox(height: 10.0),
                                Expanded(
                                  child: ListView(
                                    children: lunchItems,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text('Extras'),
                                SizedBox(height: 10.0),
                                MenuTextWidget(value: lunchExtras),
                              ],
                            ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text('Snacks'),
                                SizedBox(height: 10.0),
                                Expanded(
                                  child: ListView(
                                    children: snacksItems,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text('Extras'),
                                SizedBox(height: 10.0),
                                MenuTextWidget(value: snacksExtras),
                              ],
                            ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text('Dinner'),
                                SizedBox(height: 10.0),
                                Expanded(
                                  child:  ListView(
                                    children: dinnerItems,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text('Extras'),
                                SizedBox(height: 10.0),
                                MenuTextWidget(value: dinnerExtras),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
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

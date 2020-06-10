import 'package:flutter/material.dart';
import 'package:iiitr/home_page.dart';
import 'package:iiitr/mess_menu_screen.dart';

import 'course_schedule.dart';
import 'drawer_items.dart';

class MyDrawer extends StatefulWidget {


  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<DrawerItem> drawerItems;

  List<DrawerItem> getDrawerItemList(BuildContext context)
  {
    List<DrawerItem> drawerItems = [
      DrawerItem(
        heading: 'Mess Menu',
        leadingIcon: Icon(
          Icons.restaurant_menu,
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, MessMenuScreen.id) ;
              },
              title: Text(
                'UDH',
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, MessMenuScreen.id) ;
              },
              title: Text(
                'LDH',
              ),
            ),

          ],
        ),
        isExpanded: false,
      ),
      DrawerItem(
        heading: 'Bus Schedule',
        leadingIcon: Icon(
          Icons.directions_bus,
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Lingampally',
              ),
            ),
            ListTile(
              title: Text(
                'Sangareddy',
              ),
            ),
            ListTile(
              title: Text(
                'Main Gate',
              ),
            ),

          ],
        ),
        isExpanded: false,
      ),
      DrawerItem(
        heading: 'Course Schedule',
        leadingIcon: Icon(
          Icons.schedule,
        ),
        body:  Column(
          children: <Widget>[
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, CourseSchedule.id) ;
              },
              title: Text(
                'First Year',
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, CourseSchedule.id) ;
              },
              title: Text(
                'Second Year',
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, CourseSchedule.id) ;
              },
              title: Text(
                'Third Year',
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, CourseSchedule.id) ;
              },
              title: Text(
                'Fourth Year',
              ),
            ),

          ],
        ),
        isExpanded: false,
      ),

    ];
    return drawerItems;
  }
  @override
  void initState() {
    drawerItems = getDrawerItemList(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.school,
                    color: Colors.blue,
                    size: 60.0,
                  ),
                  // backgroundImage: AssetImage('images/temporary_logo.png'),
                  radius: 40.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'IIITR Dashboard',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),

          ),
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, HomePage.id) ;
              },
              title: Text('Home'),
              leading: Icon(
                Icons.home,
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.white30,
          ),
          ExpansionPanelList(
            expansionCallback: (int index,bool isExpanded){
              setState(() {
                drawerItems[index].isExpanded = !isExpanded;
              });
            },
            children: drawerItems.map((DrawerItem item){
              return  ExpansionPanel(
                headerBuilder: (BuildContext context,bool isExpanded){
                  return ListTile(
                    leading: item.leadingIcon,
                    title: Text(
                      item.heading,
                    ),
                  );
                },
                body: item.body,
                isExpanded: item.isExpanded,
              );

            }).toList(),
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'drawer_items.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isExpanded = [
    false,
  ];
  List<DrawerItem> drawerItems = [
    DrawerItem(
      heading: 'Mess Menu',
      leadingIcon: Icon(
        Icons.restaurant_menu,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'UDH',
            ),
          ),
          ListTile(
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
//    DrawerItem(
//      heading: 'Announcement',
//      leadingIcon: Icon(
//        Icons.announcement,
//      ),
//      isExpanded: false,
//    ),
    DrawerItem(
      heading: 'Course Schedule',
      leadingIcon: Icon(
        Icons.schedule,
      ),
      body:  Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'First Year',
            ),
          ),
          ListTile(
            title: Text(
              'Second Year',
            ),
          ),
          ListTile(
            title: Text(
              'Third Year',
            ),
          ),
          ListTile(
            title: Text(
              'Fourth Year',
            ),
          ),

        ],
      ),
      isExpanded: false,
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                    backgroundImage: AssetImage('images/temporary_logo.png'),
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
//            Card(
//              color: Theme.of(context).backgroundColor,
//              child: ListTile(
//                title: Text(
//                  'Announcement',
//                ),
//                leading: Icon(
//                  Icons.announcement,
//                ),
//                trailing: Icon(
//                  Icons.arrow_forward_ios,
//                  size: 15.0,
//                ),
//              ),
//            ),
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
      ),
      appBar: AppBar(
        title: Text(
          'IIITR',
        ),
      ),
    );
  }
}

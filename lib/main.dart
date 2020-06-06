import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'My Home';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      darkTheme: ThemeData( brightness: Brightness.dark,),
      title: appTitle,
      home: MyHomePage(title: 'App Name'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Home')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Kushagra Indurkhya"),
              accountEmail: Text("CS19B1017"),
              currentAccountPicture: CircleAvatar(backgroundColor:Colors.white,child: Text("K",style: TextStyle(fontSize: 40.0),),),
                                      ),
            ListTile(
              leading: Icon(Icons.class_), title: Text("Course Schedule"),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood), title: Text("Mess Schedule"),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'main.dart';
// void main() => runApp(new Cschedule());

class CardItemModel {
  String cardTitle;
  CardItemModel(this.cardTitle);
}
class Cschecdule extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Course',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData( brightness: Brightness.dark,),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  var cardsList = [CardItemModel("Monday"),CardItemModel("Tuesday"),CardItemModel("Wednesday"),CardItemModel("Thursday"),CardItemModel("Friday")];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(title: new Text("Course Schedule", style: TextStyle(fontSize: 25.0),),
        backgroundColor:Colors.black,
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
                  color: Colors.blueGrey[900],
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
              leading: Icon(Icons.home), title: Text("Home"),
              onTap: () {
                Navigator.push(context,new MaterialPageRoute(builder: (context) => new MyApp()),);
              },
            ),
            ListTile(
              leading: Icon(Icons.class_), title: Text("Course Schedule"),
              onTap: () {Navigator.pop(context);},
            ),
            ListTile(
              leading: Icon(Icons.fastfood), title: Text("Mess Schedule"),
              onTap: () {Navigator.pop(context);},
            ),
          ],
        ),
      ),
    );
  }
}

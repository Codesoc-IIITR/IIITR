import 'package:flutter/material.dart';
//import 'package:iiitr/course_schedule.dart';
import 'package:iiitr/my_drawer.dart';
//mport 'drawer_items.dart';

const description =  Text(
      'Day 4 of EBSB Student Exchange Program As a part of the cultural exchange program, students of IIIT SONEPAT & IIIT RAICHUR went for Hyderabad city tour. Visit includes the Salar Jung Museum - one of the three National Museums of India. With the collection of sculptures, paintings, carvings, textiles, manuscripts, ceramics, metallic artifacts, carpets, clocks, and furniture from Japan, China, Burma, Nepal, India, Persia, Egypt, Europe, and North America, it is one of the largest museums in the world. Later the team witnessed the mesmerizing beauty of the Char Minar and the Hyderabad special market of ladies ornament & pearls. The tour concluded at the Golconda Fort. Overall, it was a magnificent experience for the students.'
  );

class HomePage extends StatefulWidget {
 static  const String id = 'HomeScreen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          'IIITR Dashboard',
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                  'Hyderabad City Tour',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0,),
                          Expanded(child: Image.asset('images/hyderabad_city_tour.jpeg')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: isExpanded ? description : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

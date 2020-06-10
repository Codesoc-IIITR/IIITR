import 'package:flutter/material.dart';

class AnnouncementTile extends StatefulWidget {
  final String heading;
  final String details;

  AnnouncementTile({this.heading,this.details});
  @override
  _AnnouncementTileState createState() => _AnnouncementTileState();
}

class _AnnouncementTileState extends State<AnnouncementTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return  Padding(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
                child: Text(
                  'Hyderabad City Tour  ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: isExpanded ? Text(widget.details) : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

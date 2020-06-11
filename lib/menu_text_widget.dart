import 'package:flutter/material.dart';

class MenuTextWidget extends StatelessWidget {
  final String value;
  MenuTextWidget({this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.crop_square,
            size: 20.0,
          ),
          SizedBox(width: 10.0),
          Expanded(child: Container(child: Text('$value'))),
        ],
      ),
    );
  }
}

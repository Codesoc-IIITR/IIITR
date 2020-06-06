import 'package:flutter/material.dart';

class DrawerItem
{
  String heading;
  bool isExpanded;
  Icon leadingIcon;
  Widget body;
  DrawerItem({this.isExpanded,this.heading,this.leadingIcon,this.body});
}
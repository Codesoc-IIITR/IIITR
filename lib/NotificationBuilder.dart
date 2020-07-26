import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:iiitr/main.dart';
import 'package:iiitr/course_schedule.dart';

Future onSelectNotification(String payLoad) {
  if (payLoad != null) {
    debugPrint("$payLoad");
  }
  print("Notification Tab");
// If we tab in the notification we can set the nagivator to navigate to the next page,
}

Future<void> notificationSchedule(int notificationID, int itemNumber, List list,
    List className, List time, int day) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  NotificationDetails platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
    notificationID,
    'Scheduled Class Alert',
    'You have ${className[itemNumber]} class Scheduled between ${time[itemNumber]} ',
    Day.values[day],
    Time(int.parse('${list[itemNumber].substring(0, 2)}'),
        int.parse('${list[itemNumber].substring(3, 5)}'), 00),
    platformChannelSpecifics,
  );
}

void showNotification(int notificationID, int itemNumber, List list,
    List className, List time, int day) async {
  await notificationSchedule(
      notificationID, itemNumber, list, className, time, day);
}

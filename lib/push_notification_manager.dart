import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PushNotificationsManager {

  //PushNotificationsManager();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _initialized = prefs.getBool('boolValue') ?? false;
    print(_initialized);
    if (!_initialized) {

      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");
      Firestore.instance.collection('pushTokens').document().setData({'tokenId': '$token'});

      await prefs.setBool('boolValue', true);
    }
  }
}
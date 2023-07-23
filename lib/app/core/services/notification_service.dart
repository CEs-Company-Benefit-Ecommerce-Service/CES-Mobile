import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    String fcmToken = await getDeviceFirebaseToken() ?? "";
    GetStorage().write("fcmToken", fcmToken);

    if (kDebugMode) {
      print("fcmToken: $fcmToken");
    }
    // FirebaseMessaging.onBackgroundMessage(handleMessage);
  }
}

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseApi {
  // final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.defaultImportance);
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings
        // ,
        //     onDidReceiveBackgroundNotificationResponse: (payload) {
        //   final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        //   handleMessage(message);
        // }
        );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<String?> getDeviceFirebaseToken() async {
    String? token;

    if (kIsWeb) {
      token = await FirebaseMessaging.instance.getToken(
          vapidKey:
              "BHhNngd8WVAXLfuXi-CadIV4fBJqxjhOQbS19PN3xE1HAAVhmqrxLuky9XzK5GX_bmrammxRUlGwPdeHWgd0EgA");
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    return token;
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotification() async {
    await FirebaseMessaging.instance.requestPermission();

    String fcmToken = await getDeviceFirebaseToken() ?? "";
    final box = GetStorage();
    box.write("fcmToken", fcmToken);
    if (kDebugMode) {
      print("fcmToken: $fcmToken");
    }

    initPushNotifications();
    initLocalNotifications();
  }
}

Future<void> handleBackgroundMessage(RemoteMessage? message) async {
  if (kDebugMode) {
    print('Title: ${message?.notification?.title}');
    print('Body: ${message?.notification?.body}');
  }
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  return;
}

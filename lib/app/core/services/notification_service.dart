import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getDeviceFirebaseToken() async {
    String? token;
    if (kIsWeb) {
      token = await _firebaseMessaging.getToken(
          vapidKey:
              "BHhNngd8WVAXLfuXi-CadIV4fBJqxjhOQbS19PN3xE1HAAVhmqrxLuky9XzK5GX_bmrammxRUlGwPdeHWgd0EgA");
    } else {
      token = await _firebaseMessaging.getToken();
    }

    return token;
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    String fcmToken = await getDeviceFirebaseToken() ?? "";
    final box = GetStorage();
    box.write("fcmToken", fcmToken);

    if (kDebugMode) {
      print("fcmToken: $fcmToken");
    }
    // FirebaseMessaging.onBackgroundMessage(handleMessage);
  }
}

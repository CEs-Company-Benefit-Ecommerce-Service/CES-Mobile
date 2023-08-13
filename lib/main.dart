import 'package:ces_app/app/core/services/notification_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'generated/locales.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if (!GetPlatform.isWindows || GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseApi().initNotification();
  }

  runApp(
    //
    //     DevicePreview(
    //   enabled: true,
    //   builder: (context) => const MyApp(),
    // )
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      enableLog: true,
      // Device preview
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // Translation
      translationsKeys: AppTranslation.translations,
      // Route
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      //
      // Theme
    );
  }
}

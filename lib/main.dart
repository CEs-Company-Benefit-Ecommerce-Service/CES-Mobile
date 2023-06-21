import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() async {
  await GetStorage.init();
  runApp(
      //
      //     DevicePreview(
      //   enabled: true,
      //   builder: (context) => const MyApp(),
      // )
      const MyApp());
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
      // Theme
    );
  }
}

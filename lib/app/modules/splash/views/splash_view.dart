import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xff243763),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 90.0),
      child: Image.asset(
        "assets/images/logo-no-bg.png",
        fit: BoxFit.scaleDown,
      ),
    );
  }
}

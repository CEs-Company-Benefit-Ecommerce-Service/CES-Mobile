import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView111 extends GetView<WrapperController> {
  const WrapperView111({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        child: BottomAppBar(
          height: 70,
          elevation: 0,
          notchMargin: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(
                    icon: Icons.home,
                    page: 0,
                    context,
                    label: "Home",
                  ),
                  _bottomAppBarItem(
                      icon: Icons.history, page: 1, context, label: "Order"),
                  _bottomAppBarItem(
                      icon: Icons.wallet, page: 2, context, label: "Wallet"),
                  _bottomAppBarItem(
                      icon: Icons.person, page: 3, context, label: "Profile"),
                ],
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: controller.animateToTab,
        children: [...controller.pages],
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: controller.currentPage == page ? Colors.red : Colors.grey,
              size: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  color:
                      controller.currentPage == page ? Colors.red : Colors.grey,
                  fontSize: 13,
                  fontWeight:
                      controller.currentPage == page ? FontWeight.w600 : null),
            ),
          ],
        ),
      ),
    );
  }
}

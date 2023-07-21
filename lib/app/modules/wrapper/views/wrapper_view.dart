import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: controller.showBottomBar.value ? 70 : 0,
          child: SingleChildScrollView(
            child: BottomAppBar(
              // height: controller.showBottomBar.value ? 70 : 0,
              // elevation: 0,
              // notchMargin: 15,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bottomAppBarItem(
                        icon: Icons.home_outlined,
                        page: 0,
                        context,
                        label: "Home"),
                    _bottomAppBarItem(
                        icon: Icons.history_outlined,
                        page: 1,
                        context,
                        label: "Order"),
                    _bottomAppBarItem(
                        icon: Icons.wallet, page: 2, context, label: "Wallet"),
                    _bottomAppBarItem(
                        icon: Icons.notifications_outlined,
                        page: 3,
                        context,
                        label: "Notification"),
                    _bottomAppBarItem(
                        icon: Icons.person_outlined,
                        page: 4,
                        context,
                        label: "Profile"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
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

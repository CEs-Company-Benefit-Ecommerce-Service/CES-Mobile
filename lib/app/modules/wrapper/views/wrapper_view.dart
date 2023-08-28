import 'package:ces_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:badges/badges.dart' as badges;
import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.find<NotificationController>();

    return Scaffold(
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: controller.showBottomBar.value ? 70 : 0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: BottomAppBar(
              height: 70,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(
                      activeIcon: Icons.home,
                      icon: Icons.home_outlined,
                      page: 0,
                      context,
                      label: "Home"),
                  _bottomAppBarItem(
                      activeIcon: Icons.article,
                      icon: Icons.article_outlined,
                      page: 1,
                      context,
                      label: "Order"),
                  _bottomAppBarItem(
                      activeIcon: Icons.account_balance_wallet,
                      icon: Icons.account_balance_wallet_outlined,
                      page: 2,
                      context,
                      label: "Wallet"),
                  _bottomAppBarItem(
                    badge: !notificationController.isLoading.value ||
                            notificationController.notificationList != null
                        ? notificationController.notificationList
                            ?.any((e) => e.isRead == false)
                        : false,
                    activeIcon: Icons.notifications,
                    icon: Icons.notifications_outlined,
                    page: 3,
                    context,
                    label: "Notification",
                  ),
                  _bottomAppBarItem(
                      activeIcon: Icons.person,
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
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: controller.animateToTab,
        children: [...controller.pages],
      ),
    );
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required icon,
    required page,
    required label,
    badge,
    required activeIcon,
  }) {
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: -2, end: 0),
              badgeStyle: const badges.BadgeStyle(padding: EdgeInsets.all(3.5)),
              showBadge: badge != null && badge,
              child: Icon(
                controller.currentPage == page ? activeIcon : icon,
                color: controller.currentPage == page
                    ? Color(0xfff05150)
                    : Colors.grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                  color: controller.currentPage == page
                      ? Color(0xfff05150)
                      : Colors.grey,
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

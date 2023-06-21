import 'package:ces_app/app/modules/home/views/home_view.dart';
import 'package:ces_app/app/modules/order/views/order_view.dart';
import 'package:ces_app/app/modules/profile/views/profile_view.dart';
import 'package:ces_app/app/modules/wallet/views/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class WrapperController extends GetxController {
  late PageController pageController;
  ScrollController scrollController = ScrollController();
  var showBottomBar = true.obs;

  RxInt currentPage = 0.obs;

  List<Widget> pages = [
    const HomeView(),
    const OrderView(),
    const WalletView(),
    const ProfileView(),
  ];

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBottomBar.value = false;
      } else {
        showBottomBar.value = true;
      }
    });
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

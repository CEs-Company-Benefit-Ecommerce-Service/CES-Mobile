import 'dart:async';
import 'dart:convert';

import 'package:ces_app/app/models/user_model.dart';
import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:ces_app/app/modules/home/views/home_view.dart';
import 'package:ces_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:ces_app/app/modules/notification/views/notification_view.dart';
import 'package:ces_app/app/modules/order/controllers/order_controller.dart';
import 'package:ces_app/app/modules/order/views/order_view.dart';
import 'package:ces_app/app/modules/profile/views/profile_view.dart';
import 'package:ces_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:ces_app/app/modules/wallet/views/wallet_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class WrapperController extends GetxController {
  late PageController pageController;
  ScrollController scrollController = ScrollController();
  var showBottomBar = true.obs;

  var user = UserModel().obs;
  final box = GetStorage();

  RxInt currentPage = 0.obs;

  List<Widget> pages = [
    const HomeView(),
    const OrderView(),
    const WalletView(),
    const NotificationView(),
    const ProfileView(),
  ];

  void goToTab(int page) {
    if (page != 1) {
      var orderController = Get.find<OrderController>();
      orderController.timer?.cancel();
    }
    if (page == 0) {
      var homeController = Get.find<HomeController>();
      if (homeController.isInit) homeController.fetchData();
    } else if (page == 1) {
      var orderController = Get.find<OrderController>();
      if (orderController.isInit) {
        orderController.fetchOrderIncoming();
        orderController.timer =
            Timer.periodic(const Duration(seconds: 10), (timer) {
          orderController.fetchOrderIncoming();
        });
      }
    } else if (page == 2) {
      var walletController = Get.find<WalletController>();
      if (walletController.isInit) walletController.fetchData();
    } else if (page == 3) {
      var notificationController = Get.find<NotificationController>();
      if (notificationController.isInit) notificationController.fetchData();
    } else if (page == 4) {
      // var profileController = Get.find<ProfileController>();
      // profileController.fetchData();
    }
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
    super.onInit();
    fetchUser();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBottomBar.value = false;
      } else {
        showBottomBar.value = true;
      }
    });
    pageController = PageController(initialPage: 0);
  }

  fetchUser() async {
    try {
      String token = box.read("token");

      http.Response response = await http
          .get(Uri.tryParse('https://api-dev.ces.bio/api/login/me')!, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        user.value = UserModel.fromJson(result);
      } else {
        if (kDebugMode) {
          print('error fetching data + ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {}
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}

import 'dart:convert';

import 'package:ces_app/app/modules/order/controllers/order_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../models/notification_model.dart';
import '../../wallet/controllers/wallet_controller.dart';

class NotificationController extends GetxController {
  bool isInit = false;

  var isLoading = false.obs;
  List<NotificationModel>? notificationList;
  final box = GetStorage();
  String? token;
  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    fetchData();
  }

  void handleClickNotification(NotificationModel e) {
    final orderController = Get.find<OrderController>();
    final walletController = Get.find<WalletController>();

    fetchNotificationById(e.id!);
    fetchData();

    if (e.orderId != null) {
      orderController.currentOrderId = e.orderId;
      orderController.navigateToDetails(e.orderId);
    }

    if (e.transactionId != null) {
      walletController.currentTransactionId = e.transactionId;
      walletController.currentTransactionDetails = e.transaction;
      walletController.navigateToDetails(e.transactionId);
    }
  }

  fetchNotificationById(String id) async {
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/login/me/notification/$id')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode != 200) {
        fetchNotificationById(id);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {}
  }

  Future<void> fetchData() async {
    if (kDebugMode) {
      print("fetch data from notification controller");
    }
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchNotification());
    await Future.wait(futures);
    isLoading(false);
    isInit = true;
  }

  fetchNotification() async {
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/login/me/notification?Sort=CreatedAt&Order=desc')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        notificationList =
            data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        fetchData();
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

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

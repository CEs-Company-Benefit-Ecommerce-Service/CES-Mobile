import 'dart:async';
import 'dart:convert';

import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:ces_app/app/modules/order/controllers/order_controller.dart';
import 'package:ces_app/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  final box = GetStorage();
  HomeController homeController = Get.find();
  OrderController orderController = Get.find();
  WrapperController wrapperController = Get.find();
  var isLoading = false.obs;

  // Timer
  Timer? timer;
  final time = '05'.obs;

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  startTimer() {
    int remainingSeconds = 4;
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (timer) {
      if (remainingSeconds == 0) {
        order(homeController.cartProducts);
        timer.cancel();
        time.value = '05';
      } else {
        int seconds = remainingSeconds % 60;
        time.value = seconds.toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }

  void order(List order) async {
    String? token = box.read("token");

    var orderList = order
        .map((e) => {
              "quantity": e['count'],
              "productId": e['id'],
            })
        .toList();

    try {
      Get.back();
      isLoading(true);
      http.Response response =
          await http.post(Uri.tryParse('https://api-dev.ces.bio/api/order')!,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(orderList));

      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar("Success", "Order successfully placed");
        var result = jsonDecode(response.body);
        if (kDebugMode) {
          print("result: + $result");
        }
        homeController.clearCart();
        orderController.fetchOrderIncoming();
        Get.offAllNamed(Routes.WRAPPER, arguments: {"orderId": result['id']});
      } else {
        Get.back();
        Get.snackbar("Error", "Your balance is not enough to order");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while posting data is $e');
      }
    } finally {
      isLoading(false);
    }
  }
  // @override
  // void onInit() {
  //   super.onInit();
  // }
}

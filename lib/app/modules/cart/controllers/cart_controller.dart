import 'dart:convert';

import 'package:ces_app/app/core/utils/print.dart';
import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  final box = GetStorage();
  HomeController homeController = Get.find();
  var isLoading = false.obs;

  void order(List order) async {
    String? token = box.read("token");

    var orderList = order
        .map((e) => {
              "quantity": e['count'],
              "productId": e['id'],
            })
        .toList();

    try {
      isLoading(true);
      http.Response response =
          await http.post(Uri.tryParse('https://api-dev.ces.bio/api/orderss')!,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(orderList));

      Printt.cyan(response);

      homeController.clearCart();
      Get.offAllNamed('/wrapper');

      // if (response.statusCode == 200) {
      //   var result = jsonDecode(response.body);
      //   // loginModel = LoginModel.fromJson(result['data']);

      //   // Get.offAllNamed('/wrapper');
      // } else {
      //   if (kDebugMode) {
      //     print('error fetching data');
      //   }
      // }
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

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

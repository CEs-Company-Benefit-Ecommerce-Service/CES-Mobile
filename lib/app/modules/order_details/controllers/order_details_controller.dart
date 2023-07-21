import 'dart:async';
import 'dart:convert';

import 'package:ces_app/app/models/order_model.dart';
import 'package:ces_app/app/modules/order/controllers/order_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderDetailsController extends GetxController {
  var isLoading = false.obs;
  final OrderController orderController = Get.find<OrderController>();
  OrderModel? currentOrderDetails;
  int activeStep = 0;
  final box = GetStorage();
  String? token;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    fetchData();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchData();
    });
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  Future<void> fetchData() async {
    if (kDebugMode) {
      print("fetch data order details");
    }
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchOrderById(orderController.currentOrderId!));
    await Future.wait(futures);
    isLoading(false);
  }

  fetchOrderById(String id) async {
    try {
      http.Response response = await http.get(
          Uri.tryParse('https://api-dev.ces.bio/api/order/$id')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        currentOrderDetails = OrderModel.fromJson(result['data']);
        activeStep = currentOrderDetails!.status! - 1;
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
  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

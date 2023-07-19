import 'dart:convert';

import 'package:ces_app/app/models/order_model.dart';
import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  var isLoading = false.obs;
  List<OrderModel>? orderList;
  final box = GetStorage();
  String? token;
  String? currentOrderId;

  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    fetchData();
  }

  fetchData() async {
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchOrder());
    await Future.wait(futures);
    isLoading(false);
  }

  fetchOrder() async {
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/order?Sort=CreatedAt&Order=desc')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        orderList = data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        if (kDebugMode) {
          print('error fetching data order controller + ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {}
  }

  void navigateToDetails(id) {
    currentOrderId = id;
    Get.toNamed(Routes.ORDER_DETAILS);
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

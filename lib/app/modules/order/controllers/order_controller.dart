import 'dart:async';
import 'dart:convert';

import 'package:ces_app/app/models/order_model.dart';
import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isInit = false;
  var isLoading = false.obs;
  List<OrderModel>? orderHistoryList;
  List<OrderModel>? orderIncomingList;
  final box = GetStorage();
  String? token;
  String? currentOrderId;
  TabController? tabController;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    tabController = TabController(vsync: this, length: 2);
    fetchData();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchData();
    });
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  fetchData() async {
    if (kDebugMode) {
      print("fetch data from order controller");
    }
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchOrderIncoming());
    futures.add(fetchOrderHistory());
    await Future.wait(futures);
    isLoading(false);
    isInit = true;
  }

  fetchOrderIncoming() async {
    if (kDebugMode) {
      print("fetchOrderIncoming");
    }
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/order?Sort=CreatedAt&Order=desc&Type=1')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        orderIncomingList = data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        fetchData();
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

  fetchOrderHistory() async {
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/order?Sort=CreatedAt&Order=desc&Type=2')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        orderHistoryList = data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        fetchData();
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

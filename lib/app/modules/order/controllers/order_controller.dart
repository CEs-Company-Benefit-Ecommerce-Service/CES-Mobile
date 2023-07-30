import 'dart:async';
import 'dart:convert';

import 'package:ces_app/app/core/utils/utils.dart';
import 'package:ces_app/app/models/order_model.dart';
import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin, StateMixin {
  bool isInit = false;
  var isLoading = false.obs;
  var orderHistoryList = <OrderModel>[].obs;
  List<OrderModel> orderIncomingList = [];
  final box = GetStorage();
  String? token;
  String? currentOrderId;
  TabController? tabController;
  Timer? timer;

  // Filter
  List statusCodeFilter = [0, 4, 5];
  var currentFilterOrderStatus = 0.obs;
  List dateRangeCodeFilter = [0, 1, 2, 3, 4, 5];
  var currentFilterDateRange = 0.obs;

  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    tabController = TabController(vsync: this, length: 2);
    fetchData();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchOrderIncoming();
    });
  }

  @override
  void onClose() {
    tabController?.dispose();
    timer?.cancel();
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
    if (kDebugMode) {
      print("fetchOrderHistory");
    }
    try {
      DateRange dateRange = getDateRange(currentFilterDateRange.value);

      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/order?Sort=CreatedAt&Order=desc&${currentFilterOrderStatus.value == 0 ? "Type=2" : "Status=${currentFilterOrderStatus.value}"}&From=${Uri.encodeQueryComponent(dateRange.startDate)}&To=${Uri.encodeQueryComponent(dateRange.endDate)}')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        orderHistoryList.value =
            data.map((e) => OrderModel.fromJson(e)).toList();
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
    Get.toNamed(Routes.ORDER_DETAILS)?.then((_) => fetchData());
  }
}

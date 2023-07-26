import 'dart:convert';

import 'package:ces_app/app/models/product_model.dart';
import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController with StateMixin {
  final HomeController homeController = Get.find<HomeController>();

  var isLoading = false.obs;
  List<ProductModel> productList = [];
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    change(null, status: RxStatus.loading());
    if (kDebugMode) {
      print("fetch data from product controller");
    }
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchProduct());

    await Future.wait(futures);
    isLoading(false);
    if (productList.isEmpty) {
      change(null, status: RxStatus.empty());
    } else {
      change(null, status: RxStatus.success());
    }
    // isInit = true;
  }

  fetchProduct() async {
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/product?CategoryId=${homeController.currentCate?.id}')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        productList = data.map((e) => ProductModel.fromJson(e)).toList();
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

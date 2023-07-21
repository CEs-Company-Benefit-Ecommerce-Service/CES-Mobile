import 'dart:convert';

import 'package:ces_app/app/models/category_model.dart';
import 'package:ces_app/app/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  bool isInit = false;
  var isLoading = false.obs;
  List<ProductModel>? productList;
  List<CategoryModel>? categoryList;
  final box = GetStorage();
  String? token;
  // Add to cart
  var isAddedToCart = false.obs;
  var selectedProduct = {};
  var cartProducts = [].obs;

  void addToCart(ProductModel product) {
    bool productExists = false;
    int productIndex = -1;
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i]['id'] == product.id) {
        productExists = true;
        productIndex = i;
        break;
      }
    }
    if (!productExists) {
      cartProducts.add({
        ...product.toJson(),
        "count": 1,
      });
    } else {
      cartProducts[productIndex]['count'] += 1;
    }

    cartProducts.refresh();
  }

  void decrease(ProductModel product) {
    bool productExists = false;
    int productIndex = -1;

    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i]['id'] == product.id) {
        productExists = true;
        productIndex = i;
        break;
      }
    }

    if (productExists) {
      if (cartProducts[productIndex]['count'] > 0) {
        cartProducts[productIndex]['count'] -= 1;
        if (cartProducts[productIndex]['count'] == 0) {
          cartProducts.removeAt(productIndex);
        }
      }
    }
    cartProducts.refresh();
  }

  void clearCart() {
    cartProducts.clear();
  }

  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    fetchData();
  }

  void navigateToCart() {
    Get.toNamed("/cart");
  }

  Future<void> fetchData() async {
    print("fetch data from home controller");
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchProduct());
    futures.add(fetchCategory());
    await Future.wait(futures);
    isLoading(false);
    isInit = true;
  }

  fetchProduct() async {
    try {
      http.Response response = await http
          .get(Uri.tryParse('https://api-dev.ces.bio/api/product')!, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
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

  fetchCategory() async {
    try {
      http.Response response = await http
          .get(Uri.tryParse('https://api-dev.ces.bio/api/category')!, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        categoryList = data.map((e) => CategoryModel.fromJson(e)).toList();
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
}

// @override
// void onReady() {
//   super.onReady();
// }

// @override
// void onClose() {
//   super.onClose();
// }

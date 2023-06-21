import 'dart:convert';

import 'package:ces_app/app/models/category_model.dart';
import 'package:ces_app/app/models/product_model.dart';
import 'package:ces_app/app/models/wallet_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = false.obs;
  List<ProductModel>? productList;
  List<CategoryModel>? categoryList;
  List<WalletModel>? walletList;
  final box = GetStorage();

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

    fetchData();
  }

  void navigateToCart() {
    Get.toNamed("/cart");
  }

  fetchData() async {
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchProduct());
    futures.add(fetchCategory());
    futures.add(fetchWallet());
    await Future.wait(futures);
    isLoading(false);
  }

  fetchProduct() async {
    String? token = box.read("token");
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
          print('error fetching data');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {}
  }

  fetchCategory() async {
    String? token = box.read("token");

    print(box.read("accountId"));
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
          print('error fetching data');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {}
  }

  fetchWallet() async {
    String? token = box.read("token");
    String? accountId = box.read("accountId");
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/wallet/account/$accountId')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        walletList = data.map((e) => WalletModel.fromJson(e)).toList();
      } else {
        if (kDebugMode) {
          print('error fetching data');
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

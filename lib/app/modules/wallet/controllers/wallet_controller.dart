import 'dart:convert';

import 'package:ces_app/app/models/wallet_model.dart';
import 'package:ces_app/app/models/wallet_transaction_model.dart';
import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class WalletController extends GetxController {
  bool isInit = false;
  var isLoading = false.obs;
  var showBalance = false.obs;
  List<WalletTransactionModel>? walletTransactionList;
  List<WalletModel>? walletList;
  String? currentTransactionId;
  WalletTransactionModel? currentTransactionDetails;
  final box = GetStorage();
  String? token;

  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    fetchData();
  }

  void navigateToDetails(id) {
    currentTransactionId = id;
    Get.toNamed(Routes.TRANSACTION_DETAILS);
  }

  fetchData() async {
    if (kDebugMode) {
      print("fetch data from wallet controller");
    }
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchWallet());
    futures.add(fetchWalletTransaction());
    await Future.wait(futures);
    isLoading(false);
    isInit = true;
  }

  fetchWallet() async {
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

  fetchWalletTransaction() async {
    try {
      http.Response response = await http.get(
          Uri.tryParse(
              'https://api-dev.ces.bio/api/transaction/wallet-transaction?Sort=CreatedAt&Order=desc')!,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['data'];

        walletTransactionList =
            data.map((e) => WalletTransactionModel.fromJson(e)).toList();
      } else {
        fetchData();

        if (kDebugMode) {
          print('error fetching data walletTransactionList + ${response.body}');
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

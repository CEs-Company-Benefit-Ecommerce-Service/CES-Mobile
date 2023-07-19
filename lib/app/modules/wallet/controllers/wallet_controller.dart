import 'dart:convert';

import 'package:ces_app/app/models/wallet_transaction_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class WalletController extends GetxController {
  var isLoading = false.obs;
  List<WalletTransactionModel>? walletTransactionList;
  final box = GetStorage();
  String? token;

  @override
  void onInit() {
    super.onInit();
    token = box.read("token");
    fetchData();
  }

  fetchData() async {
    isLoading(true);
    final futures = <Future>[];
    futures.add(fetchWalletTransaction());
    await Future.wait(futures);
    isLoading(false);
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

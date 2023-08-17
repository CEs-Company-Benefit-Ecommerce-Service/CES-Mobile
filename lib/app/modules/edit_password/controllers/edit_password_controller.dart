import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class EditPasswordController extends GetxController {
  final editPasswordKey = GlobalKey<FormBuilderState>();
  var showOldPass = true.obs;
  var showNewPass = true.obs;
  var showConfirmPass = true.obs;
  var isLoading = false.obs;

  void changePassword() async {
    if (editPasswordKey.currentState!.saveAndValidate()) {
      try {
        isLoading(true);
        String token = GetStorage().read("token");

        var payload = {
          "oldPassword": editPasswordKey.currentState?.value['oldPassword'],
          "newPassword": editPasswordKey.currentState?.value['newPassword']
        };

        http.Response response = await http.put(
            Uri.tryParse('https://api-dev.ces.bio/api/account/password')!,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(payload));

        if (response.statusCode == 200) {
          Get.back();
          Get.snackbar("Success", "Change password successfully");
        } else {
          Get.snackbar("Error", "Old password not correct");
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error while update password data is $e');
        }
      } finally {
        isLoading(false);
      }
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

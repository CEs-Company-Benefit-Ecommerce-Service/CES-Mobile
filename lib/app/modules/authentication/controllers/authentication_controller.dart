import 'dart:convert';

import 'package:ces_app/app/models/login_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final loginKey = GlobalKey<FormBuilderState>();
  final box = GetStorage();

  var isLoading = false.obs;
  LoginModel? loginModel;

  void login() async {
    if (loginKey.currentState!.saveAndValidate()) {
      try {
        isLoading(true);
        http.Response response =
            await http.post(Uri.tryParse('https://api-dev.ces.bio/api/login')!,
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(loginKey.currentState?.value));
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          loginModel = LoginModel.fromJson(result['data']);

          // set token
          box.write("accountId", loginModel?.account?.id);
          box.write("token", loginModel?.token?.accessToken);

          Get.offNamed('/wrapper');
        } else {
          if (kDebugMode) {
            print('error fetching data');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error while getting data is $e');
        }
      } finally {
        // isLoading(false);
        // Get.delete<AuthenticationController>();
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

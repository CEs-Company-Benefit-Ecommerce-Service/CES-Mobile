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
  var showPass = false.obs;

  LoginModel? loginModel;

  void login() async {
    if (loginKey.currentState!.saveAndValidate()) {
      try {
        isLoading(true);

        var payload = {
          "email": loginKey.currentState?.value['email'],
          "password": loginKey.currentState?.value['password'],
          "fcmToken": box.read("fcmToken") ?? ""
        };
        http.Response response =
            await http.post(Uri.tryParse('https://api-dev.ces.bio/api/login')!,
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(payload));
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          loginModel = LoginModel.fromJson(result['data']);

          box.write("accountId", loginModel?.account?.id);
          box.write("token", loginModel?.token?.accessToken);

          Get.offAllNamed('/wrapper');
        } else {
          Get.snackbar("Error", "Email or Password is not correct");
          if (kDebugMode) {
            print(
              'login api + ${response.body}',
            );
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error while getting data is $e');
        }
      } finally {
        isLoading(false);
      }
    }
  }
}

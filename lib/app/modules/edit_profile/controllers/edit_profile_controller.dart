import 'dart:convert';

import 'package:ces_app/app/models/account_payload_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../wrapper/controllers/wrapper_controller.dart';

class EditProfileController extends GetxController {
  final editProfileKey = GlobalKey<FormBuilderState>();
  final WrapperController wrapperController = Get.find<WrapperController>();
  final box = GetStorage();
  void editProfile() async {
    if (editProfileKey.currentState!.saveAndValidate()) {
      try {
        String token = box.read("token");

        AccountPayloadModel payload = AccountPayloadModel(
          name: editProfileKey.currentState?.value['name'],
          phone: editProfileKey.currentState?.value['phone'],
          email: wrapperController.user.value.email,
          // imageUrl: wrapperController.user?.imageUrl,
          role: wrapperController.user.value.role,
          companyId: wrapperController.user.value.companyId,
        );

        http.Response response = await http.put(
            Uri.tryParse(
                'https://api-dev.ces.bio/api/account/${wrapperController.user.value.id}')!,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(payload));

        if (response.statusCode == 200) {
          await wrapperController.fetchUser();
          Get.back();
        }

        // if (response.statusCode == 200) {
        //   var result = jsonDecode(response.body);
        //   // loginModel = LoginModel.fromJson(result['data']);

        //   Get.offNamed('/wrapper');
        // } else {
        //   if (kDebugMode) {
        //     print(
        //       'login api + ${response.body}',
        //     );
        //   }
        // }
      } catch (e) {
        if (kDebugMode) {
          print('Error while getting data is $e');
        }
      } finally {
        // isLoading(false);
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

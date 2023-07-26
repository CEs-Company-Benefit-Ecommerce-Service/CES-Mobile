import 'package:ces_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SplashController extends GetxController {
  @override
  void onInit() async {
    String? token = GetStorage().read("token");
    if (token != null && token != "") {
      try {
        http.Response response = await http.get(
            Uri.tryParse('https://api-dev.ces.bio/api/login/me')!,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            });
        if (response.statusCode == 200) {
          Get.offAllNamed(Routes.WRAPPER);
        } else {
          Get.toNamed(Routes.AUTHENTICATION);
        }
      } catch (e) {
        Get.toNamed(Routes.AUTHENTICATION);
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed(Routes.AUTHENTICATION);
      });
    }
    super.onInit();
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

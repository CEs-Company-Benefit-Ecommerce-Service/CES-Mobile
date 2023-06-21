import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WrapperController>(
      () => WrapperController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

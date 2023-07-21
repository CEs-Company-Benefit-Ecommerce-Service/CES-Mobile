import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:ces_app/app/modules/order/controllers/order_controller.dart';
import 'package:ces_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:ces_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WrapperController>(
      () => WrapperController(),
    );
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
    // Get.lazyPut<OrderController>(
    //   () => OrderController(),
    // );
    // Get.lazyPut<WalletController>(
    //   () => WalletController(),
    // );
    // Get.lazyPut<ProfileController>(
    //   () => ProfileController(),
    // );
  }
}

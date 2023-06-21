import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CartView'),
        centerTitle: true,
      ),
      body: Column(children: [
        ...homeController.cartProducts
            .map((element) => Text(element['name']))
            .toList(),
        ElevatedButton(
            onPressed: () {
              controller.order(homeController.cartProducts);
            },
            child: Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : Text("Order")))
      ]),
    );
  }
}

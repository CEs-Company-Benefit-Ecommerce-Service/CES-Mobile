import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    var subTotal = homeController.cartProducts
        .fold(0, (sum, item) => sum + item['price'] * item['count'] as int);
    var fee = 5000;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Your order',
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total:",
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 16)),
                      Text(
                        "${subTotal + fee}đ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ]),
              ),
              Expanded(
                  flex: 2,
                  child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff243763)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          onPressed: () =>
                              controller.order(homeController.cartProducts),
                          child: const Text("Order")))),
            ]),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 8),
                    Text("Please check correctly delivery place")
                  ]),
                  const Divider(),
                  Row(children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Company A - D1 SHTP",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.chevron_right,
                                color: Colors.grey)))
                  ]),
                  const Divider(),
                  Row(children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Delivery now:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.chevron_right,
                                color: Colors.grey)))
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Your order",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: const Text(
                              "Add more",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...homeController.cartProducts
                      .map((e) => Container(
                            height: 48,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                    aspectRatio: 1,
                                    child: e['imageUrl'] != null
                                        ? Image.network(
                                            e['imageUrl'],
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/placeholder.jpg",
                                            fit: BoxFit.cover,
                                          )),
                                const SizedBox(width: 8),
                                Text("${e['count']} x"),
                                const SizedBox(width: 8),
                                Text(e['name']),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.topRight,
                                        child: Text("${e['price']}đ")))
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your bill",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal"),
                        Text(
                          "$subTotalđ",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Fee"),
                        Text("$feeđ"),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        Text(
                          "${subTotal + fee}đ",
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(height: 8),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(children: [
                      const Icon(
                        Icons.assignment_outlined,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Add Voucher",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              )))
                    ]),
                    const Divider(),
                    Row(children: [
                      const Icon(
                        Icons.note_outlined,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Note",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              )))
                    ]),
                  ],
                )),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}

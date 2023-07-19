import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "${controller.currentOrderDetails?.orderDetails?.first.product?.supplier?.account?.name}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                      "${controller.currentOrderDetails?.total}đ - ${controller.currentOrderDetails!.orderDetails!.fold(0, (sum, product) => sum + product.quantity!)} item"),
                  const SizedBox(height: 4),
                  Text(
                      "${controller.currentOrderDetails?.employee?.account?.name} - ${controller.currentOrderDetails?.employee?.account?.phone}"),
                  const SizedBox(height: 8),
                  const Divider(),
                  // const SizedBox(height: 8),
                  ...(controller.currentOrderDetails?.orderDetails ?? [])
                      .map((e) => Container(
                            height: 48,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                    aspectRatio: 1,
                                    child: e.product?.imageUrl != null &&
                                            e.product?.imageUrl != "" &&
                                            e.product?.imageUrl != "string"
                                        ? Image.network(
                                            e.product!.imageUrl!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/placeholder.jpg",
                                            fit: BoxFit.cover,
                                          )),
                                const SizedBox(width: 8),
                                Text("${e.quantity} x"),
                                const SizedBox(width: 8),
                                Text("${e.product?.name}"),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.topRight,
                                        child: Text("${e.product?.price}đ")))
                              ],
                            ),
                          )),
                  // const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your bill",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subtotal"),
                              Text(
                                "${controller.currentOrderDetails?.total}đ",
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Fee"),
                              Text("0đ"),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                              Text(
                                "${controller.currentOrderDetails?.total}đ",
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
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Order details",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Notes"),
                              Text(
                                controller.currentOrderDetails?.notes ?? "",
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Order code"),
                              Text(
                                "${controller.currentOrderDetails?.id}",
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Order time"),
                              Text(DateFormat('hh:mm dd/MM/yyyy').format(
                                  DateTime.parse(controller
                                      .currentOrderDetails!.createdAt!))),
                            ],
                          ),
                        ]),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: 36,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff243763)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                              onPressed: () => {},
                              child: const Text("Re-order"))),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ))),
    );
  }
}

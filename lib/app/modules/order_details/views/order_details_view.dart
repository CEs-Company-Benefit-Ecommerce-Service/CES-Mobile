import 'package:easy_stepper/easy_stepper.dart';
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
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.more_horiz_rounded),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: Obx(() => controller.isLoading.value &&
              controller.currentOrderDetails == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 16, horizontal: 8),
                    child: EasyStepper(
                      activeStep: controller.activeStep,
                      lineLength: 64,
                      lineSpace: 0,
                      disableScroll: true,
                      lineType: LineType.normal,
                      defaultLineColor: Colors.grey.shade400,
                      finishedLineColor: Colors.red,
                      finishedStepBackgroundColor: Colors.grey.shade500,
                      finishedStepTextColor: Colors.grey.shade400,
                      internalPadding: 24,
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 32, horizontal: 24),
                      showLoadingAnimation: false,
                      stepRadius: 8,
                      showStepBorder: false,
                      lineThickness: 0.5,
                      steps: [
                        EasyStep(
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: controller.activeStep >= 0
                                ? Colors.red
                                : Colors.grey.shade400,
                          ),
                          enabled: false,
                          customTitle: Text(
                            'Pending',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 2,
                              fontWeight: controller.activeStep == 0
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                              color: controller.activeStep == 0
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                        EasyStep(
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: controller.activeStep >= 1
                                ? Colors.red
                                : Colors.grey.shade400,
                          ),
                          enabled: false,
                          customTitle: Text(
                            'Confirmed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 2,
                              fontWeight: controller.activeStep == 1
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                              color: controller.activeStep == 1
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                        EasyStep(
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: controller.activeStep >= 2
                                ? Colors.red
                                : Colors.grey.shade400,
                          ),
                          enabled: false,
                          customTitle: Text(
                            'Shipping',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 2,
                                fontWeight: controller.activeStep == 2
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: controller.activeStep == 2
                                    ? Colors.black
                                    : Colors.grey.shade400),
                          ),
                        ),
                        EasyStep(
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: controller.activeStep >= 3
                                ? Colors.red
                                : Colors.grey.shade400,
                          ),
                          enabled: false,
                          customTitle: Text(
                            'Done',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 2,
                                fontWeight: controller.activeStep == 3
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: controller.activeStep == 3
                                    ? Colors.black
                                    : Colors.grey.shade400),
                          ),
                        ),
                      ],
                      onStepReached: (index) {},
                    ),
                  ),
                  const Divider(),
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
                  const Divider(),
                  const SizedBox(height: 8),
                  Column(
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
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Column(
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
                              "${controller.currentOrderDetails?.orderCode}",
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

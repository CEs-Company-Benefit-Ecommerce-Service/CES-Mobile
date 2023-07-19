import 'package:ces_app/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/order_controller.dart';

String statusCodeToString(int? statusCode) {
  if (statusCode != null) {
    switch (statusCode) {
      case 1:
        return "New";
      case 2:
        return "Confirm";
      case 3:
        return "Waiting for ship";
      case 4:
        return "Complete";
      case 5:
        return "Cancel";
      default:
        return "";
    }
  }
  return "";
}

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WrapperController wrapperController = Get.find<WrapperController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Order',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            color: Colors.black,
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
          child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.red,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(
                      text: "Current order",
                    ),
                    Tab(
                      text: "History",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
              children: [
                SingleChildScrollView(
                    controller: wrapperController.scrollController,
                    child: Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                const SizedBox(height: 4),
                                ...(controller.orderList ?? []).map(
                                  (e) => Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.navigateToDetails(e.id);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("#${e.id}"),
                                                Text(DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.parse(
                                                        e.createdAt!)))
                                              ],
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              height: 80,
                                              child: Row(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image:
                                                              DecorationImage(
                                                                  fit:
                                                                      BoxFit
                                                                          .cover,
                                                                  image: e.orderDetails?.first.product?.supplier?.account?.imageUrl !=
                                                                              null &&
                                                                          e.orderDetails?.first.product?.supplier?.account?.imageUrl !=
                                                                              "" &&
                                                                          e.orderDetails?.first.product?.supplier?.account?.imageUrl !=
                                                                              "string"
                                                                      ? NetworkImage(
                                                                          e
                                                                              .orderDetails!
                                                                              .first
                                                                              .product!
                                                                              .supplier!
                                                                              .account!
                                                                              .imageUrl!,
                                                                        )
                                                                      : Image.asset(
                                                                              "assets/images/placeholder.jpg")
                                                                          .image)),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(e
                                                              .orderDetails
                                                              ?.first
                                                              .product
                                                              ?.supplier
                                                              ?.supplierName ??
                                                          "Supplier Name"),
                                                      const SizedBox(height: 8),
                                                      Text("${e.total}"),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(statusCodeToString(
                                                      e.status)),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.red),
                                                      onPressed: () {},
                                                      child: const Text(
                                                          "Re-order"))
                                                ]),
                                          ]),
                                        ),
                                      ),
                                      Container(
                                          height: 12,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    )),
                const Center(
                  child: Text("It's rainy here"),
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}

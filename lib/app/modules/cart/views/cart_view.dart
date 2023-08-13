import 'package:cached_network_image/cached_network_image.dart';
import 'package:ces_app/app/models/product_model.dart';
import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final WrapperController wrapperController = Get.find<WrapperController>();
    final HomeController homeController = Get.find<HomeController>();
    var subTotal = homeController.cartProducts
        .fold(0, (sum, item) => sum + item['price'] * item['count'] as int);
    var fee = 5000;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 0.5,
        centerTitle: true,
        title: const Text('Your order',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total:",
                      style:
                          TextStyle(color: Colors.grey.shade800, fontSize: 16)),
                  Text(
                    "${NumberFormat.decimalPattern().format(fee + subTotal)}đ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ]),
          ),
          Expanded(
              flex: 2,
              child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff243763),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              // controller.startTimer();
                              return AlertDialog(
                                // title: Obx(() => Text(controller.time.value)),
                                content: const Text(
                                    "Are you sure to place an order?"),
                                actions: [
                                  TextButton(
                                      child: Text("Cancel",
                                          style: TextStyle(
                                              color: Colors.grey.shade600)),
                                      onPressed: () {
                                        Get.back();
                                        // controller.timer?.cancel();
                                        // controller.time.value = '05';
                                      }),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor:
                                            const Color(0xff243763)),
                                    child: const Text("Order"),
                                    onPressed: () => controller
                                        .order(homeController.cartProducts),
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            // controller.timer?.cancel();
                          });
                        },
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text("Order")))),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // const Text("Delivery address"),
          // Text(wrapperController.user.value.address ?? "Company address"),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your order",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        foregroundColor: const Color(0xff243763)),
                    child: const Text('Add more'),
                  ),
                ],
              ),
              Obx(() => Column(
                    children: [
                      ...homeController.cartProducts.map((a) => InkWell(
                            onTap: () {
                              homeController.updateTempCartProduct();

                              showModalBottomSheet(
                                  useSafeArea: true,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                        ),
                                        height: context.height * 0.8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 4),
                                            Center(
                                              child: Container(
                                                height: 4,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade400,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: CachedNetworkImage(
                                                  imageBuilder: (_,
                                                          imageProvider) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                  // fit: BoxFit.cover,
                                                  imageUrl: a["imageUrl"],
                                                  placeholder: (_, url) =>
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(),
                                                      ),
                                                  errorWidget: (_, url,
                                                          error) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black45)),
                                                        child: const Icon(
                                                            Icons.error,
                                                            color:
                                                                Colors.black45,
                                                            size: 20),
                                                      )),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              a['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: Text(
                                                "${NumberFormat.decimalPattern().format(a["price"])}đ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Row(children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: IntrinsicHeight(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xff243763)),
                                                          ),
                                                          child: InkWell(
                                                              onTap: () {
                                                                homeController
                                                                    .decrease(
                                                                        ProductModel
                                                                            .fromJson(
                                                                          a,
                                                                        ),
                                                                        true);
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xff243763),
                                                                size: 20,
                                                              )),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      24),
                                                          child: Obx(() => Text(
                                                              homeController.tempCartProduct.firstWhereOrNull((element) =>
                                                                          element[
                                                                              'id'] ==
                                                                          a[
                                                                              'id']) !=
                                                                      null
                                                                  ? homeController
                                                                      .tempCartProduct
                                                                      .firstWhereOrNull((element) =>
                                                                          element[
                                                                              'id'] ==
                                                                          a[
                                                                              'id'])[
                                                                          'count']
                                                                      .toString()
                                                                  : "0",
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ))),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xff243763)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: InkWell(
                                                              onTap: () {
                                                                homeController.addToCart(
                                                                    ProductModel
                                                                        .fromJson(
                                                                            a),
                                                                    true);
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xff243763),
                                                                size: 20,
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 4,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      backgroundColor:
                                                          const Color(
                                                              0xff243763),
                                                      foregroundColor:
                                                          Colors.white,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16,
                                                          horizontal: 8),
                                                    ),
                                                    onPressed: () {
                                                      homeController
                                                          .updateCartProductFromTemp();
                                                      Get.back();
                                                    },
                                                    child: const Text(
                                                        "Update order")),
                                              )
                                            ]),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ));
                            },
                            child: Column(children: [
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 48,
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: (a['imageUrl'] != "" &&
                                                a['imageUrl'] != 'string' &&
                                                a['imageUrl'] != null)
                                            ? CachedNetworkImage(
                                                imageBuilder: (_,
                                                        imageProvider) =>
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                imageUrl: a['imageUrl'],
                                                placeholder: (_, url) =>
                                                    Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(),
                                                    ),
                                                errorWidget: (_, url, error) =>
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black45)),
                                                      child: const Icon(
                                                          Icons.error,
                                                          color: Colors.black45,
                                                          size: 20),
                                                    ))
                                            : Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.black45)),
                                                child: const Icon(Icons.error,
                                                    color: Colors.black45,
                                                    size: 20),
                                              )),
                                  ),
                                  const SizedBox(width: 8),
                                  Text("${a['count']}x"),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(a['name'])),
                                  Text(
                                    "${NumberFormat.decimalPattern().format(a['price'])}đ",
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 0)
                            ]),
                          ))
                    ],
                  )),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      // isScrollControlled: true,
                      useSafeArea: true,
                      context: context,
                      builder: (context) => Container());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(children: [
                    Icon(Icons.list_alt_outlined),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Notes",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ]),
                ),
              ),
            ]),
          ),

          Container(
              height: 8,
              decoration: BoxDecoration(color: Colors.grey.shade200)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Your bill",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal"),
                    Text(
                      "${NumberFormat.decimalPattern().format(subTotal)}đ",
                    ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Delivery fee"),
                    Text("${NumberFormat.decimalPattern().format(fee)}đ"),
                  ],
                ),
                const Divider(height: 24),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount"),
                    Text("0"),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    Text(
                      "${NumberFormat.decimalPattern().format(fee + subTotal)}đ",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32)
        ]),
      ),
    );
  }
}

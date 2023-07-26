import 'package:cached_network_image/cached_network_image.dart';
import 'package:ces_app/app/core/utils/extension/app_extension.dart';
import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          '${homeController.currentCate?.name}',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: Obx(() => Visibility(
            visible: homeController.cartProducts.isNotEmpty,
            child: BottomAppBar(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Builder(builder: (context) {
                final itemCount = homeController.cartProducts
                    .fold(0, (sum, item) => sum + (item['count'] as int));
                final totalPrice = homeController.cartProducts.fold(
                    0,
                    (sum, item) =>
                        sum + (item['count'] * item["price"] as int));
                return Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            foregroundColor: const Color(0xff243763),
                            side: const BorderSide(color: Color(0xff243763)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag, size: 20),
                              const SizedBox(width: 8),
                              Text("$itemCount")
                            ],
                          ),
                        )),
                    const SizedBox(width: 16),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          onPressed: () {
                            homeController.navigateToCart();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: const Color(0xff243763),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Checkout"),
                              const SizedBox(width: 8),
                              const Text(
                                "-",
                              ),
                              const SizedBox(width: 8),
                              Text(
                                  "${NumberFormat.decimalPattern().format(totalPrice)}đ")
                            ],
                          ),
                        ))
                  ],
                );
              }),
            ),
          )),
      // floatingActionButton: Obx(() => Visibility(
      //       visible: homeController.cartProducts.isNotEmpty,
      //       child: badges.Badge(
      //         position: badges.BadgePosition.topEnd(top: -4, end: 2),
      //         badgeContent: Text(
      //           homeController.cartProducts
      //               .fold(0, (sum, item) => sum + (item['count'] as int))
      //               .toString(),
      //           style: TextStyle(
      //               color: Colors.white,
      //               fontSize: homeController.cartProducts.fold(0,
      //                           (sum, item) => sum + (item['count'] as int)) >=
      //                       10
      //                   ? 10
      //                   : 12),
      //         ),
      //         child: FloatingActionButton(
      //           backgroundColor: Colors.white,
      //           onPressed: () {
      //             homeController.navigateToCart();
      //           },
      //           mini: true,
      //           shape: const RoundedRectangleBorder(),
      //           child: const Icon(
      //             Icons.shopping_cart,
      //             color: Color(0xff243763),
      //           ),
      //         ),
      //       ),
      //     )),
      body: controller.obx(
        (_) => Obx(() => SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ...controller.productList.map((item) {
                        var isAddedToCartItem = homeController.cartProducts
                                .firstWhereOrNull(
                                    (element) => element['id'] == item.id) !=
                            null;

                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              height: 120,
                              child: Row(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                      imageBuilder: (_, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      imageUrl: item.imageUrl!,
                                      placeholder: (_, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(),
                                      ),
                                      errorWidget: (_, url, error) =>
                                          const Icon(Icons.error,
                                              color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name!.toCapitalized(),
                                          style: const TextStyle(
                                            height: 1.6,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          item.category!.name!,
                                          style: TextStyle(
                                            height: 1.6,
                                            fontSize: 14,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${NumberFormat.decimalPattern().format(item.price)}đ",
                                                style: const TextStyle(
                                                    height: 1.6,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              isAddedToCartItem
                                                  ? Row(
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
                                                                        item);
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xff243763),
                                                                size: 20,
                                                              )),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16),
                                                          child: Text(
                                                            homeController.cartProducts.firstWhereOrNull((element) =>
                                                                        element[
                                                                            'id'] ==
                                                                        item
                                                                            .id) !=
                                                                    null
                                                                ? homeController
                                                                    .cartProducts
                                                                    .firstWhereOrNull((element) =>
                                                                        element[
                                                                            'id'] ==
                                                                        item
                                                                            .id)[
                                                                        'count']
                                                                    .toString()
                                                                : "0",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
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
                                                                homeController
                                                                    .addToCart(
                                                                        item);
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xff243763),
                                                                size: 20,
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  : OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0,
                                                                horizontal: 16),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        foregroundColor:
                                                            const Color(
                                                                0xff243763),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xff243763)),
                                                      ),
                                                      onPressed: () {
                                                        homeController
                                                            .addToCart(item);
                                                      },
                                                      child: const Text("Add"))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      }),
                    ],
                  )),
            )),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: const Center(child: Text('No data found')),
        onError: (error) => Text(error ?? "Error"),
      ),
    );
  }
}

import 'dart:math';

import 'package:ces_app/app/core/utils/extension/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../wrapper/controllers/wrapper_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final HomeController controller = Get.put(HomeController());
    final WrapperController wrapperController = Get.find<WrapperController>();
    List<String> assetList = [
      'assets/icons/diet.png',
      'assets/icons/bibimbap.png',
      'assets/icons/fast-food.png',
      'assets/icons/food.png',
      'assets/icons/ramen.png',
      'assets/icons/snack.png',
      // Add more asset paths here as needed
    ];

    return Scaffold(
      bottomNavigationBar: Obx(() => InkWell(
            onTap: () => controller.navigateToCart(),
            child: Container(
              // color: Colors.red,
              height: controller.cartProducts.isNotEmpty ? 50 : 0,
              // padding: EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.shopping_bag_outlined),
                          SizedBox(width: 2),
                          Text(
                            controller.cartProducts
                                .fold(0,
                                    (sum, item) => sum + item['count'] as int)
                                .toString(),
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        alignment: Alignment.center,
                        color: Colors.red,
                        width: Get.width / 3,
                        child: const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ))
                  ]),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: wrapperController.scrollController,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text("Deliver To:"),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Text("Company A - D1 SHTP")
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Colors.grey.shade600),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Search ...",
                          style: TextStyle(color: Colors.grey.shade600),
                        )
                      ]),
                  // decoration: BoxDecoration(),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: Get.width,
                  height: 160,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: AssetImage("assets/images/placeholder.jpg"),
                          fit: BoxFit.cover)),
                  child: Text("Banner here"),
                ),
                // CarouselSlider(
                //   options: CarouselOptions(
                //     height: 160,
                //     enableInfiniteScroll: true,
                //   ),
                //   items: [1, 2, 3].map((i) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         return Container(
                //             width: MediaQuery.of(context).size.width,
                //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
                //             decoration: const BoxDecoration(color: Colors.grey),
                //             child: Center(
                //               child: Text(
                //                 'text $i',
                //                 style: TextStyle(fontSize: 16.0),
                //               ),
                //             ));
                //       },
                //     );
                //   }).toList(),
                // ),
                SizedBox(
                  height: 24,
                ),
                Container(
                    height: 88,
                    child: Obx(
                      () => controller.isLoading.value
                          ? Container()
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                // ...(controller.categoryList ?? []).map((item) {
                                //       return Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 16),
                                //         child: Column(
                                //           children: [
                                //             Container(
                                //               width: 48,
                                //               height: 48,
                                //               decoration: BoxDecoration(
                                //                   shape: BoxShape.circle,
                                //                   image: DecorationImage(
                                //                       image: AssetImage(
                                //                           'assets/icons/food.png'),
                                //                       fit: BoxFit.cover)),
                                //             ),
                                //             SizedBox(height: 4),
                                //             Text(item.name ?? "no name")
                                //           ],
                                //         ),
                                //       );
                                //     }).toList(),
                                ...(controller.categoryList ?? [])
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key % assetList.length;
                                  final assetPath = assetList[index];
                                  final item = entry.value;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(assetPath),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(item.name ?? "no name"),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                    )),

                Obx(() => controller.isLoading.value
                    ? Container()
                    : Row(
                        children: [
                          ...(controller.walletList ?? []).map((e) {
                            return Expanded(
                              child: Container(
                                margin: e != controller.walletList?.last
                                    ? const EdgeInsets.only(right: 8)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.name ?? "Wallet name"),
                                    const SizedBox(height: 4),
                                    Text(
                                      e.balance.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      )),

                SizedBox(
                  height: 24,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: controller.productList?.map((item) {
                                var isAddedToCartItem = controller.cartProducts
                                        .firstWhereOrNull((element) =>
                                            element['id'] == item.id) !=
                                    null;

                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 120,
                                      child: Row(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: item.imageUrl !=
                                                              null
                                                          ? NetworkImage(
                                                              item.imageUrl!,
                                                            )
                                                          : NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/my-storage-ces.appspot.com/o/image%2Fdownload%20(1).jpeg3f6d38b0-1fe3-4bce-954c-036a442b4599?alt=media&token=f93f418f-75d0-4a97-9761-cbe49c4d176d'))),
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
                                                  style: TextStyle(
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${item.price} đ",
                                                        style: TextStyle(
                                                            height: 1.6,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      isAddedToCartItem
                                                          ? Row(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                    color: Color(
                                                                        0xff243763),
                                                                  ),
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        controller
                                                                            .decrease(item);
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      )),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8),
                                                                  child: Text(controller.cartProducts.firstWhereOrNull((element) =>
                                                                              element['id'] ==
                                                                              item
                                                                                  .id) !=
                                                                          null
                                                                      ? controller
                                                                          .cartProducts
                                                                          .firstWhereOrNull((element) =>
                                                                              element['id'] ==
                                                                              item.id)['count']
                                                                          .toString()
                                                                      : "0"),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                    color: Color(
                                                                        0xff243763),
                                                                  ),
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        controller
                                                                            .addToCart(item);
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      )),
                                                                )
                                                              ],
                                                            )
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: Color(
                                                                    0xff243763),
                                                              ),
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .addToCart(
                                                                            item);
                                                                  },
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  )))
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
                              }).toList() ??
                              []),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ces_app/app/core/utils/extension/app_extension.dart';
import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: [
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: Colors.grey.shade500),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Search ...",
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 14),
                      )
                    ]),
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.PROFILE);
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => Visibility(
            visible: controller.cartProducts.isNotEmpty,
            child: Stack(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    controller.navigateToCart();
                  },
                  mini: true,
                  shape: const RoundedRectangleBorder(),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xff243763),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      controller.cartProducts
                          .fold(0, (sum, item) => sum + (item['count'] as int))
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: wrapperController.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CarouselSlider(
                options: CarouselOptions(
                  // height: 160,
                  aspectRatio: 2 / 1,
                  viewportFraction: 0.9,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                ),
                items: [1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                              color: i == 1
                                  ? Colors.blue
                                  : i == 2
                                      ? Colors.red
                                      : Colors.green,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              'Banner $i',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ));
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Obx(() => controller.isLoading.value && !controller.isInit
                      ? Container()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...(controller.categoryList ?? [])
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key % assetList.length;
                                final assetPath = assetList[index];
                                final item = entry.value;

                                return Container(
                                  width: 64,
                                  margin: const EdgeInsets.symmetric(
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
                                      const SizedBox(height: 8),
                                      Text(item.name!),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                  // : Flexible(
                  //     child: ListView(
                  //       scrollDirection: Axis.horizontal,
                  //       // shrinkWrap: true,
                  //       children: [
                  //         ...(controller.categoryList ?? [])
                  //             .asMap()
                  //             .entries
                  //             .map((entry) {
                  //           final index = entry.key % assetList.length;
                  //           final assetPath = assetList[index];
                  //           final item = entry.value;

                  //           return Container(
                  //             alignment: Alignment.center,
                  //             width: 60,
                  //             margin:
                  //                 const EdgeInsets.symmetric(horizontal: 16),
                  //             child: Column(
                  //               children: [
                  //                 Container(
                  //                   width: 48,
                  //                   height: 48,
                  //                   decoration: BoxDecoration(
                  //                     shape: BoxShape.circle,
                  //                     image: DecorationImage(
                  //                       image: AssetImage(assetPath),
                  //                       fit: BoxFit.cover,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 4),
                  //                 Flexible(child: Text(item.name!)),
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //       ],
                  //     ),
                  //   ),
                  ),
              const SizedBox(height: 24),
              Obx(
                () => (controller.isLoading.value && !controller.isInit)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Buy now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                              const SizedBox(height: 8),
                              ...(controller.productList ?? []).map((item) {
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
                                              ),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: item.imageUrl!,
                                                placeholder: (_, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(),
                                                ),
                                                errorWidget: (_, url, error) =>
                                                    const Icon(Icons.error,
                                                        color: Colors.grey),
                                              ),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${NumberFormat.decimalPattern().format(item.price)} đ",
                                                        style: const TextStyle(
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
                                                                    color: const Color(
                                                                        0xff243763),
                                                                  ),
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        controller
                                                                            .decrease(item);
                                                                      },
                                                                      child: const Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      )),
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets
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
                                                                    color: const Color(
                                                                        0xff243763),
                                                                  ),
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        controller
                                                                            .addToCart(item);
                                                                      },
                                                                      child: const Icon(
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
                                                                color: const Color(
                                                                    0xff243763),
                                                              ),
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .addToCart(
                                                                            item);
                                                                  },
                                                                  child:
                                                                      const Icon(
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
                              })
                            ]),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

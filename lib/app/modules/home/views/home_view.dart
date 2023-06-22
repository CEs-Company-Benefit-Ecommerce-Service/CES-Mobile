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
    ];

    return Scaffold(
      // backgroundColor: Colors.grey.shade200,
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
      bottomNavigationBar: Obx(() => InkWell(
            onTap: () => controller.navigateToCart(),
            child: SizedBox(
              height: controller.cartProducts.isNotEmpty ? 50 : 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Stack(children: [
                            const Icon(Icons.shopping_bag_outlined),
                            Positioned(
                              top: -5,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Builder(builder: (context) {
                                  final itemCount = controller.cartProducts
                                      .fold(
                                          0,
                                          (sum, item) =>
                                              sum + (item['count'] as int));
                                  return Text(
                                    itemCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: InkWell(
                        onTap: () => controller.navigateToCart(),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: wrapperController.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text("Deliver To:"),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            Text("Company A - D1 SHTP")
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade300,
                          ),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.search, color: Colors.grey.shade600),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Search ...",
                                  style: TextStyle(color: Colors.grey.shade600),
                                )
                              ]),
                          // decoration: BoxDecoration(),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          // width: Get.width,
                          height: 160,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey,
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/placeholder.jpg"),
                                  fit: BoxFit.cover)),
                          child: const Text("Banner here"),
                        ),
                        const SizedBox(height: 24),
                      ])),

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
                  height: 88,
                  child: Obx(
                    () => controller.isLoading.value
                        ? Container()
                        : ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
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
                                      const SizedBox(height: 4),
                                      Text(item.name ?? "no name"),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                  )),

              Container(height: 8, color: Colors.grey.shade200),

              Obx(() => controller.isLoading.value
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Row(
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    )),

              // const SizedBox(
              //   height: 24,
              // ),
              Container(height: 8, color: Colors.grey.shade200),

              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Buy now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                              const SizedBox(height: 4),
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
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: item.imageUrl !=
                                                              null
                                                          ? NetworkImage(
                                                              item.imageUrl!,
                                                            )
                                                          : Image.asset(
                                                                  "assets/images/placeholder.jpg")
                                                              .image)),
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
                                                        "${item.price} đ",
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
                              }).toList()
                            ]),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

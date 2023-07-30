import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ces_app/app/core/utils/extension/app_extension.dart';
import 'package:ces_app/app/models/product_model.dart';
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
    final WrapperController wrapperController = Get.find<WrapperController>();

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 60,
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
      bottomNavigationBar: Obx(() => Visibility(
            visible: controller.cartProducts.isNotEmpty,
            child: BottomAppBar(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Builder(builder: (context) {
                final itemCount = controller.cartProducts
                    .fold(0, (sum, item) => sum + (item['count'] as int));
                final totalPrice = controller.cartProducts.fold(
                    0,
                    (sum, item) =>
                        sum + (item['count'] * item["price"] as int));
                return Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                useSafeArea: true,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10)),
                                      ),
                                      height: context.height * 0.8,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors.red,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16,
                                                        horizontal: 0),
                                                  ),
                                                  onPressed: () {
                                                    controller.clearCart();
                                                    Get.back();
                                                  },
                                                  child:
                                                      const Text("Clear all")),
                                              const Text("Update cart",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16)),
                                              IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              )
                                            ],
                                          ),
                                          const Divider(),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(children: [
                                                ...controller.cartProducts
                                                    .map((item) => Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                              child:
                                                                  IntrinsicHeight(
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    AspectRatio(
                                                                      aspectRatio:
                                                                          1,
                                                                      child: (item['imageUrl'] != "" &&
                                                                              item['imageUrl'] != 'string' &&
                                                                              item['imageUrl'] != null)
                                                                          ? CachedNetworkImage(
                                                                              imageBuilder: (_, imageProvider) => Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                      image: DecorationImage(
                                                                                        image: imageProvider,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                              imageUrl: item['imageUrl'],
                                                                              placeholder: (_, url) => Shimmer.fromColors(
                                                                                    baseColor: Colors.grey.shade300,
                                                                                    highlightColor: Colors.grey.shade100,
                                                                                    child: Container(),
                                                                                  ),
                                                                              errorWidget: (_, url, error) => Container(
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black45)),
                                                                                    child: const Icon(Icons.error, color: Colors.black45, size: 20),
                                                                                  ))
                                                                          : Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black45)),
                                                                              child: const Icon(Icons.error, color: Colors.black45, size: 20),
                                                                            ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            16),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            item['name'].toString().toCapitalized(),
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  "${NumberFormat.decimalPattern().format(item["price"])} đ",
                                                                                  style: const TextStyle(height: 1.6, fontWeight: FontWeight.w700),
                                                                                ),
                                                                                IntrinsicHeight(
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                    children: [
                                                                                      Container(
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                          border: Border.all(color: const Color(0xff243763)),
                                                                                        ),
                                                                                        child: InkWell(
                                                                                            onTap: () {
                                                                                              controller.decrease(ProductModel.fromJson(item));
                                                                                            },
                                                                                            child: const Icon(
                                                                                              Icons.remove,
                                                                                              color: Color(0xff243763),
                                                                                              size: 20,
                                                                                            )),
                                                                                      ),
                                                                                      Container(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                                        child: Obx(() => Text(
                                                                                              controller.cartProducts.firstWhereOrNull((element) => element['id'] == item['id']) != null ? controller.cartProducts.firstWhereOrNull((element) => element['id'] == item['id'])['count'].toString() : "0",
                                                                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                            )),
                                                                                      ),
                                                                                      Container(
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border.all(color: const Color(0xff243763)),
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                        ),
                                                                                        child: InkWell(
                                                                                            onTap: () {
                                                                                              controller.addToCart(ProductModel.fromJson(item));
                                                                                            },
                                                                                            child: const Icon(
                                                                                              Icons.add,
                                                                                              color: Color(0xff243763),
                                                                                              size: 20,
                                                                                            )),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const Divider(
                                                                height: 8)
                                                          ],
                                                        ))
                                              ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            foregroundColor: const Color(0xff243763),
                            side: const BorderSide(color: Color(0xff243763)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
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
                        child: OutlinedButton(
                          onPressed: () {
                            controller.navigateToCart();
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: const Color(0xff243763),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
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
      //       visible: controller.cartProducts.isNotEmpty,
      //       child: badges.Badge(
      //         position: badges.BadgePosition.topEnd(top: -4, end: 2),
      //         badgeContent: Text(
      //           controller.cartProducts
      //               .fold(0, (sum, item) => sum + (item['count'] as int))
      //               .toString(),
      //           style: TextStyle(
      //               color: Colors.white,
      //               fontSize: controller.cartProducts.fold(0,
      //                           (sum, item) => sum + (item['count'] as int)) >=
      //                       10
      //                   ? 10
      //                   : 12),
      //         ),
      //         child: FloatingActionButton(
      //           backgroundColor: Colors.white,
      //           onPressed: () {
      //             controller.navigateToCart();
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
      body: SafeArea(
        child: SingleChildScrollView(
          controller: wrapperController.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.5 / 1,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                ),
                items: [
                  "assets/images/banner1.jpg",
                  "assets/images/banner2.jpg",
                  "assets/images/banner3.jpg"
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(i),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Obx(() => controller.isLoading.value && !controller.isInit
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Category list",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.CATEGORY);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "View all",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey.shade600,
                                      size: 24,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...(controller.categoryList ?? []).map((cat) {
                                return Container(
                                  width: 60,
                                  // height: 80,
                                  margin: EdgeInsets.only(
                                      left: cat.id !=
                                              controller.categoryList?.first.id
                                          ? 40
                                          : 0),
                                  child: InkWell(
                                    onTap: () {
                                      controller.navigateToProduct(cat);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 48,
                                          width: 48,
                                          child: (cat.imageUrl != "" &&
                                                  cat.imageUrl != 'string' &&
                                                  cat.imageUrl != null)
                                              ? CachedNetworkImage(
                                                  imageBuilder:
                                                      (_, imageProvider) =>
                                                          Container(
                                                    decoration: BoxDecoration(
                                                      // shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  imageUrl: cat.imageUrl!,
                                                  placeholder: (_, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(),
                                                  ),
                                                  errorWidget:
                                                      (_, url, error) =>
                                                          Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          "assets/icons/bibimbap.png",
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/icons/bibimbap.png",
                                                      ),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(height: 8),
                                        AutoSizeText(
                                          cat.name!,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    )),
              const SizedBox(height: 8),
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
                                            child: (item.imageUrl != "" &&
                                                    item.imageUrl != 'string' &&
                                                    item.imageUrl != null)
                                                ? CachedNetworkImage(
                                                    imageBuilder: (_,
                                                            imageProvider) =>
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                    imageUrl: item.imageUrl!,
                                                    placeholder: (_, url) =>
                                                        Shimmer.fromColors(
                                                          baseColor: Colors
                                                              .grey.shade300,
                                                          highlightColor: Colors
                                                              .grey.shade100,
                                                          child: Container(),
                                                        ),
                                                    errorWidget:
                                                        (_, url, error) =>
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
                                                                  color: Colors
                                                                      .black45,
                                                                  size: 20),
                                                            ))
                                                : Container(
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
                                                          ? IntrinsicHeight(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0xff243763)),
                                                                    ),
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          controller
                                                                              .decrease(item);
                                                                        },
                                                                        child: const Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Color(0xff243763),
                                                                          size:
                                                                              20,
                                                                        )),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            16),
                                                                    child: Text(
                                                                      controller.cartProducts.firstWhereOrNull((element) => element['id'] == item.id) !=
                                                                              null
                                                                          ? controller
                                                                              .cartProducts
                                                                              .firstWhereOrNull((element) => element['id'] == item.id)['count']
                                                                              .toString()
                                                                          : "0",
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0xff243763)),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          controller
                                                                              .addToCart(item);
                                                                        },
                                                                        child: const Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Color(0xff243763),
                                                                          size:
                                                                              20,
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                minimumSize:
                                                                    const Size(
                                                                        64, 28),
                                                                // padding: const EdgeInsets
                                                                //         .symmetric(
                                                                //     vertical: 8,
                                                                //     horizontal:
                                                                //         24),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                foregroundColor:
                                                                    const Color(
                                                                        0xff243763),
                                                                side: const BorderSide(
                                                                    color: Color(
                                                                        0xff243763)),
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                    .addToCart(
                                                                        item);
                                                              },
                                                              child: const Text(
                                                                "Add",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ))
                                                      // : Container(
                                                      //     padding: EdgeInsets
                                                      //         .symmetric(
                                                      //             horizontal:
                                                      //                 16,
                                                      //             vertical:
                                                      //                 4),
                                                      //     decoration:
                                                      //         BoxDecoration(
                                                      //       border: Border.all(
                                                      //           color: Color(
                                                      //               0xff243763)),
                                                      //       borderRadius:
                                                      //           BorderRadius
                                                      //               .circular(
                                                      //                   20),
                                                      //     ),
                                                      //     child: const Text(
                                                      //       "Add",
                                                      //       style:
                                                      //           TextStyle(
                                                      //         color: Color(
                                                      //             0xff243763),
                                                      //       ),
                                                      //     ))
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

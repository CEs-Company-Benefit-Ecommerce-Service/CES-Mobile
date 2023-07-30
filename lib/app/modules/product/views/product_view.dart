import 'package:cached_network_image/cached_network_image.dart';
import 'package:ces_app/app/core/utils/extension/app_extension.dart';
import 'package:ces_app/app/models/product_model.dart';
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
      // bottomNavigationBar: Obx(() => Visibility(
      //       visible: homeController.cartProducts.isNotEmpty,
      //       child: BottomAppBar(
      //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //         child: Builder(builder: (context) {
      //           final itemCount = homeController.cartProducts
      //               .fold(0, (sum, item) => sum + (item['count'] as int));
      //           final totalPrice = homeController.cartProducts.fold(
      //               0,
      //               (sum, item) =>
      //                   sum + (item['count'] * item["price"] as int));
      //           return Row(
      //             children: [
      //               Expanded(
      //                   flex: 1,
      //                   child: OutlinedButton(
      //                     onPressed: () {
      //                       showModalBottomSheet(
      //                           shape: const RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.vertical(
      //                                   top: Radius.circular(8))),
      //                           context: context,
      //                           builder: (context) => Column(
      //                                 children: [
      //                                   Padding(
      //                                     padding: const EdgeInsets.symmetric(
      //                                         horizontal: 12, vertical: 8),
      //                                     child: Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.spaceBetween,
      //                                       children: [
      //                                         const Text("Choose order status",
      //                                             style: TextStyle(
      //                                                 fontWeight:
      //                                                     FontWeight.w500,
      //                                                 fontSize: 16)),
      //                                         IconButton(
      //                                           icon: const Icon(Icons.close),
      //                                           onPressed: () {
      //                                             Get.back();
      //                                           },
      //                                         )
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   const Divider(height: 0),
      //                                   const SizedBox(height: 4),
      //                                 ],
      //                               ));
      //                     },
      //                     style: OutlinedButton.styleFrom(
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(8),
      //                       ),
      //                       foregroundColor: const Color(0xff243763),
      //                       side: const BorderSide(color: Color(0xff243763)),
      //                       padding: const EdgeInsets.symmetric(
      //                           vertical: 8, horizontal: 8),
      //                     ),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         const Icon(Icons.shopping_bag, size: 20),
      //                         const SizedBox(width: 8),
      //                         Text("$itemCount")
      //                       ],
      //                     ),
      //                   )),
      //               const SizedBox(width: 16),
      //               Expanded(
      //                   flex: 4,
      //                   child: ElevatedButton(
      //                     onPressed: () {
      //                       homeController.navigateToCart();
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(8),
      //                       ),
      //                       backgroundColor: const Color(0xff243763),
      //                       foregroundColor: Colors.white,
      //                       padding: const EdgeInsets.symmetric(
      //                           vertical: 8, horizontal: 8),
      //                     ),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         const Text("Checkout"),
      //                         const SizedBox(width: 8),
      //                         const Text(
      //                           "-",
      //                         ),
      //                         const SizedBox(width: 8),
      //                         Text(
      //                             "${NumberFormat.decimalPattern().format(totalPrice)}đ")
      //                       ],
      //                     ),
      //                   ))
      //             ],
      //           );
      //         }),
      //       ),
      //     )),
      bottomNavigationBar: Obx(() {
        final itemCount = homeController.cartProducts
            .fold(0, (sum, item) => sum + (item['count'] as int));
        final totalPrice = homeController.cartProducts.fold(
            0, (sum, item) => sum + (item['count'] * item['price'] as int));

        return Visibility(
          visible: homeController.cartProducts.isNotEmpty,
          child: BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 0),
                                            ),
                                            onPressed: () {
                                              homeController.clearCart();
                                              Get.back();
                                            },
                                            child: const Text("Clear all")),
                                        const Text("Update cart",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
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
                                          ...homeController.cartProducts
                                              .map((item) => Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8),
                                                        child: IntrinsicHeight(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              AspectRatio(
                                                                aspectRatio: 1,
                                                                child: (item['imageUrl'] != "" &&
                                                                        item['imageUrl'] !=
                                                                            'string' &&
                                                                        item['imageUrl'] !=
                                                                            null)
                                                                    ? CachedNetworkImage(
                                                                        imageBuilder: (_,
                                                                                imageProvider) =>
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                image: DecorationImage(
                                                                                  image: imageProvider,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        imageUrl:
                                                                            item[
                                                                                'imageUrl'],
                                                                        placeholder: (_,
                                                                                url) =>
                                                                            Shimmer
                                                                                .fromColors(
                                                                              baseColor: Colors.grey.shade300,
                                                                              highlightColor: Colors.grey.shade100,
                                                                              child: Container(),
                                                                            ),
                                                                        errorWidget: (_,
                                                                                url,
                                                                                error) =>
                                                                            Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black45)),
                                                                              child: const Icon(Icons.error, color: Colors.black45, size: 20),
                                                                            ))
                                                                    : Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            border: Border.all(color: Colors.black45)),
                                                                        child: const Icon(
                                                                            Icons
                                                                                .error,
                                                                            color:
                                                                                Colors.black45,
                                                                            size: 20),
                                                                      ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      item['name']
                                                                          .toString()
                                                                          .toCapitalized(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "${NumberFormat.decimalPattern().format(item["price"])} đ",
                                                                            style:
                                                                                const TextStyle(height: 1.6, fontWeight: FontWeight.w700),
                                                                          ),
                                                                          IntrinsicHeight(
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                              children: [
                                                                                Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    border: Border.all(color: const Color(0xff243763)),
                                                                                  ),
                                                                                  child: InkWell(
                                                                                      onTap: () {
                                                                                        homeController.decrease(ProductModel.fromJson(item));
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
                                                                                        homeController.cartProducts.firstWhereOrNull((element) => element['id'] == item['id']) != null ? homeController.cartProducts.firstWhereOrNull((element) => element['id'] == item['id'])['count'].toString() : "0",
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
                                                                                        homeController.addToCart(ProductModel.fromJson(item));
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
                                                      const Divider(height: 8)
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
                        Text("$itemCount"),
                      ],
                    ),
                  ),
                ),
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
                          vertical: 16, horizontal: 8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Checkout"),
                        const SizedBox(width: 8),
                        const Text("-"),
                        const SizedBox(width: 8),
                        Text(
                            "${NumberFormat.decimalPattern().format(totalPrice)}đ"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),

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
                                      child: (item.imageUrl != "" &&
                                              item.imageUrl != 'string' &&
                                              item.imageUrl != null)
                                          ? CachedNetworkImage(
                                              imageBuilder: (_,
                                                      imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
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
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.black45)),
                                              child: const Icon(Icons.error,
                                                  color: Colors.black45,
                                                  size: 20),
                                            )),
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
                                                                child:
                                                                    const Icon(
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
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Color(
                                                                      0xff243763),
                                                                  size: 20,
                                                                )),
                                                          )
                                                        ],
                                                      ),
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

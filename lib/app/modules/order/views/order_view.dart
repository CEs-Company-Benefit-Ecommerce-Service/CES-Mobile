import 'package:cached_network_image/cached_network_image.dart';
import 'package:ces_app/app/core/utils/utils.dart';
import 'package:ces_app/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WrapperController wrapperController = Get.find<WrapperController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 0.5,
        title: const Text(
          'Order',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: controller.tabController,
              onTap: (tabIndex) {
                if (tabIndex == 0) {
                  controller.fetchOrderIncoming();
                } else {
                  controller.fetchOrderHistory();
                }
              },
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.red,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: const [
                Tab(
                  text: "Incoming",
                ),
                Tab(
                  text: "History",
                ),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: controller.tabController,
            children: [
              Obx(
                () => controller.isLoading.value && !controller.isInit
                    ? const Center(child: CircularProgressIndicator())
                    : CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: SingleChildScrollView(
                              controller: wrapperController.scrollController,
                              child: Column(
                                children: [
                                  const SizedBox(height: 4),
                                  ...controller.orderIncomingList.map(
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                      child: Text(
                                                          "#${e.orderCode}")),
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
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageBuilder:
                                                            (_, imageProvider) =>
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
                                                        imageUrl: e
                                                            .orderDetails!
                                                            .first
                                                            .product!
                                                            .supplier!
                                                            .account!
                                                            .imageUrl!,
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
                                                            const Icon(
                                                                Icons.error,
                                                                color: Colors
                                                                    .grey),
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
                                                        const SizedBox(
                                                            height: 8),
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
                                                        e.status!)),
                                                  ]),
                                            ]),
                                          ),
                                        ),
                                        Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Obx(() => controller.isLoading.value && !controller.isInit
                  ? const Center(child: CircularProgressIndicator())
                  : CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          scrolledUnderElevation: 0.5,
                          pinned: true,
                          backgroundColor: Colors.grey[50],
                          flexibleSpace: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: controller
                                                    .currentFilterOrderStatus
                                                    .value ==
                                                0
                                            ? Colors.grey.shade300
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            useRootNavigator: true,
                                            isScrollControlled: false,
                                            useSafeArea: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            8))),
                                            context: context,
                                            builder: (context) => Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                              "Choose order status",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16)),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(height: 0),
                                                    const SizedBox(height: 4),
                                                    ...controller
                                                        .statusCodeFilter
                                                        .map(
                                                      (e) => InkWell(
                                                        onTap: () {
                                                          controller
                                                              .currentFilterOrderStatus
                                                              .value = e;
                                                          controller
                                                              .fetchOrderHistory();

                                                          Get.back();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 8),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    statusCodeToString(
                                                                        e)),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: controller.currentFilterOrderStatus == e
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .transparent),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 32),
                                                  ],
                                                ));
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 4),
                                          Text(
                                            controller.currentFilterOrderStatus
                                                        .value ==
                                                    0
                                                ? "Status"
                                                : statusCodeToString(controller
                                                    .currentFilterOrderStatus
                                                    .value),
                                            style: TextStyle(
                                                color: controller
                                                            .currentFilterOrderStatus
                                                            .value ==
                                                        0
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          Icon(Icons.keyboard_arrow_down,
                                              color: controller
                                                          .currentFilterOrderStatus
                                                          .value ==
                                                      0
                                                  ? Colors.black
                                                  : Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: controller.currentFilterDateRange
                                                    .value ==
                                                0
                                            ? Colors.grey.shade300
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            8))),
                                            context: context,
                                            builder: (BuildContext context) =>
                                                SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 12,
                                                                vertical: 8),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                  "Choose date range",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16)),
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ]),
                                                      ),
                                                      const Divider(height: 0),
                                                      const SizedBox(height: 4),
                                                      ...controller
                                                          .dateRangeCodeFilter
                                                          .map(
                                                        (e) => InkWell(
                                                          onTap: () {
                                                            controller
                                                                .currentFilterDateRange
                                                                .value = e;
                                                            controller
                                                                .fetchOrderHistory();
                                                            Get.back();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        8),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      dateRangeCodeToString(
                                                                          e)),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: controller.currentFilterDateRange ==
                                                                                e
                                                                            ? Colors.red
                                                                            : Colors.transparent),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 32),
                                                    ],
                                                  ),
                                                ));
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 4),
                                          Text(
                                            controller.currentFilterDateRange
                                                        .value ==
                                                    0
                                                ? "Date range"
                                                : dateRangeCodeToString(
                                                    controller
                                                        .currentFilterDateRange
                                                        .value),
                                            style: TextStyle(
                                                color: controller
                                                            .currentFilterDateRange
                                                            .value ==
                                                        0
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          Icon(Icons.keyboard_arrow_down,
                                              color: controller
                                                          .currentFilterDateRange
                                                          .value ==
                                                      0
                                                  ? Colors.black
                                                  : Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SingleChildScrollView(
                            controller: wrapperController.scrollController,
                            child: Column(
                              children: [
                                const SizedBox(height: 4),
                                ...controller.orderHistoryList.map(
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                    child: Text(
                                                        "#${e.orderCode}")),
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
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageBuilder:
                                                          (_, imageProvider) =>
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
                                                      imageUrl: e
                                                          .orderDetails!
                                                          .first
                                                          .product!
                                                          .supplier!
                                                          .account!
                                                          .imageUrl!,
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
                                                          const Icon(
                                                              Icons.error,
                                                              color:
                                                                  Colors.grey),
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
                                                      Text(
                                                          "${NumberFormat.decimalPattern().format(e.total)}đ"),
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
                                                      e.status!)),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        // minimumSize:
                                                        //     const Size(64, 28),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0,
                                                                horizontal: 16),
                                                      ),
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
                          ),
                        ),
                      ],
                    )),
            ],
          ))
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ces_app/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WrapperController wrapperController = Get.find<WrapperController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        controller: wrapperController.scrollController,
        child: Obx(
          () => controller.isLoading.value && controller.isInit == false
              ? SizedBox(
                  height: Get.height / 2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(children: [
                  const SizedBox(height: 4),
                  ...(controller.notificationList ?? []).map((e) => InkWell(
                        onTap: () {
                          controller.handleClickNotification(e);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              Opacity(
                                opacity: e.isRead! ? 0.5 : 1,
                                child: Column(
                                  children: [
                                    // const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: e.orderId != null
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.red)
                                              // color: Colors.red,
                                              ),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: e.orderId != null
                                                ? CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: e
                                                        .order!
                                                        .orderDetails!
                                                        .first
                                                        .product!
                                                        .supplier!
                                                        .account!
                                                        .imageUrl!,
                                                    placeholder: (_, url) =>
                                                        Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(),
                                                    ),
                                                    errorWidget: (_, url,
                                                            error) =>
                                                        const Icon(Icons.error,
                                                            color: Colors.grey),
                                                  )
                                                : const Icon(
                                                    Icons.attach_money_outlined,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat('dd/MM/yyyy hh:mm')
                                                    .format(DateTime.parse(
                                                        e.createdAt!)),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Text(
                                                "${e.title}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text("${e.description}"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    // const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 0),
                            ],
                          ),
                        ),
                      ))
                ]),
        ),
      ),
    );
  }
}

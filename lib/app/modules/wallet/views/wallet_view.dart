import 'package:ces_app/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WrapperController wrapperController = Get.find<WrapperController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Wallet info',
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
      body: Obx(
        () => controller.isLoading.value && controller.isInit == false
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: wrapperController.scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 20, color: Colors.red.shade300),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(200),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 32),
                            const Text("Current balance"),
                            const SizedBox(height: 8),
                            Text(
                                controller.showBalance.value
                                    ? "${NumberFormat.decimalPattern().format(controller.walletList?.first.balance)}đ"
                                    : "***",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            IconButton(
                                onPressed: () {
                                  controller.showBalance.toggle();
                                },
                                icon: Icon(
                                  controller.showBalance.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                        height: 8,
                        decoration: BoxDecoration(color: Colors.grey.shade300)),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Column(
                        children: [
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Transaction history",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                              Text(
                                "View all",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ...(controller.walletTransactionList ?? []).map((e) =>
                            InkWell(
                              onTap: () {
                                controller.currentTransactionDetails = e;
                                controller.navigateToDetails(e.id);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.description}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              DateFormat('dd/MM/yyyy hh:mm')
                                                  .format(DateTime.parse(
                                                      e.createdAt!)),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            "${e.type == 1 ? "+" : "-"}${NumberFormat.decimalPattern().format(e.total)}đ",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Divider(height: 0),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 32)
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:ces_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/transaction_details_controller.dart';

class TransactionDetailsView extends GetView<TransactionDetailsController> {
  const TransactionDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Transaction Details',
          style: TextStyle(color: Colors.black),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.more_horiz_rounded),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              height: 40,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Icon(
                                  Icons.money,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "${walletController.currentTransactionDetails?.type == 1 ? "+" : "-"}${NumberFormat.decimalPattern().format(walletController.currentTransactionDetails?.total)}đ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Status"),
                              Text(
                                "Success",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),
                        const SizedBox(height: 8),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Time"),
                              Text(
                                DateFormat('dd/MM/yyyy hh:mm')
                                    .format(DateTime.parse(
                                  walletController
                                      .currentTransactionDetails!.createdAt!,
                                )),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),
                        const SizedBox(height: 8),
                        const Divider(),
                        const Text("Transaction Code"),
                        const SizedBox(height: 4),
                        Text(
                            "${walletController.currentTransactionDetails?.id}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Text("Transaction Details"),
                        //       Flexible(
                        //         child: Text(
                        //             "${walletController.currentTransactionDetails?.id}"),
                        //       ),
                        //     ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

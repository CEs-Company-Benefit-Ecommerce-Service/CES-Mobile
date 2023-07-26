import 'package:cached_network_image/cached_network_image.dart';
import 'package:ces_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Category',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              crossAxisSpacing: 48,
              mainAxisSpacing: 32,
              crossAxisCount: 3,
              // childAspectRatio: 1.2,
              children: [
                ...(homeController.categoryList ?? []).map((cat) => InkWell(
                      onTap: () {
                        homeController.navigateToProduct(cat);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: (cat.imageUrl != "" &&
                                        cat.imageUrl != 'string' &&
                                        cat.imageUrl != null)
                                    ? CachedNetworkImage(
                                        imageUrl: cat.imageUrl!,
                                        placeholder: (_, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(),
                                        ),
                                        errorWidget: (_, url, error) =>
                                            Image.asset(
                                                "assets/icons/bibimbap.png"),
                                      )
                                    : Image.asset("assets/icons/bibimbap.png"),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(cat.name!)
                          ],
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

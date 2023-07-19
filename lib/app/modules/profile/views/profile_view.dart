import 'package:ces_app/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WrapperController wrapperController = Get.find<WrapperController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          elevation: 0.5,
          title: const Text(
            'Profile Info',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          wrapperController.user.value.imageUrl != "" &&
                                  wrapperController.user.value.imageUrl !=
                                      null &&
                                  wrapperController.user.value.imageUrl !=
                                      "string"
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    wrapperController.user.value.imageUrl!,
                                  ),
                                )
                              : const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  child: Icon(Icons.person),
                                ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${wrapperController.user.value.name}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              Text("${wrapperController.user.value.email}"),
                              Text("${wrapperController.user.value.phone}"),
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.EDIT_PROFILE);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xff243763),
                        ))
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  "Account",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.list_alt,
                                color: Colors.green.shade800,
                              ),
                              const SizedBox(width: 8),
                              const Text("Order"),
                            ]),
                            const Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              SizedBox(width: 8),
                              Text("Favorite"),
                            ]),
                            Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.language,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text("Language"),
                            ]),
                            Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.MANAGE_ACCOUNT);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.settings_outlined,
                                color: Colors.green,
                              ),
                              SizedBox(width: 8),
                              Text("Manage account"),
                            ]),
                            Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "General",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.list_alt,
                                color: Colors.yellow.shade900,
                              ),
                              SizedBox(width: 8),
                              Text("Privacy & Terms"),
                            ]),
                            Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.help_center_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text("Help center"),
                            ]),
                            Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.feedback_outlined,
                                color: Colors.yellow.shade800,
                              ),
                              const SizedBox(width: 8),
                              const Text("Feedback"),
                            ]),
                            const Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:ces_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/manage_account_controller.dart';

class ManageAccountView extends GetView<ManageAccountController> {
  const ManageAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 0.5,
        title: const Text(
          'Manage Account',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.EDIT_PROFILE);
              },
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.person_outline,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text("Profile info"),
                        ]),
                        Icon(Icons.arrow_forward_ios, size: 12)
                      ],
                    ),
                  ),
                  Divider(height: 0),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.EDIT_PASSWORD);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.password_outlined,
                            color: Colors.green.shade900,
                          ),
                          const SizedBox(width: 8),
                          const Text("Password"),
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
              onTap: () {
                Get.toNamed(Routes.EDIT_PASSWORD);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.blue.shade900,
                          ),
                          const SizedBox(width: 8),
                          const Text("Logout"),
                        ]),
                        const Icon(Icons.arrow_forward_ios, size: 12)
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                ],
              ),
            ),

            // InkWell(
            //   onTap: () {},
            //   child: const Column(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(children: [
            //               Icon(
            //                 Icons.language,
            //                 color: Colors.blue,
            //               ),
            //               SizedBox(width: 8),
            //               Text("Delete Account"),
            //             ]),
            //             Icon(Icons.arrow_forward_ios, size: 12)
            //           ],
            //         ),
            //       ),
            //       Divider(height: 0),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

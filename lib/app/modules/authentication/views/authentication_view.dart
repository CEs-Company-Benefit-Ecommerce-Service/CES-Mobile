import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          // TODO: Change to get.height after test
          height: context.height,
          child: SingleChildScrollView(
            child: FormBuilder(
              key: controller.loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height / 3,
                    color: const Color(0xfff05150),
                    // color: const Color(0xff243763),
                    alignment: Alignment.center,
                    child: Center(
                      child: Image.asset(
                        // 'assets/images/logo-no-bg.png',
                        'assets/images/logo_web2_full.png',
                        width: 240,
                        color: Colors.white,
                        // height: 160,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FormBuilderTextField(
                      name: 'email',
                      initialValue: "empdemo1@gmail.com",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(() => FormBuilderTextField(
                          name: 'password',
                          initialValue: "123456",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          obscureText: !controller.showPass.value,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: controller.showPass.value
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: () {
                                  controller
                                      .showPass(!controller.showPass.value);
                                },
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        )),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.login(),
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: const Color(0xff243763),
                            backgroundColor: const Color(0xfff05150),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text('Login'),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

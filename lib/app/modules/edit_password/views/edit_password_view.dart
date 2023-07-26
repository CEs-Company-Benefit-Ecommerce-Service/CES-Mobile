import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          elevation: 0.5,
          title: const Text(
            'Edit Info',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.changePassword();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Colors.red,
                ),
                child: const Text("Save"),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: controller.editPasswordKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text("Old Password"),
                  const SizedBox(height: 4),
                  Obx(() => FormBuilderTextField(
                        obscureText: controller.showOldPass.value,
                        name: 'oldPassword',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6),
                        ]),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          suffixIcon: IconButton(
                            icon: controller.showOldPass.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              controller
                                  .showOldPass(!controller.showOldPass.value);
                            },
                          ),
                          filled: true,
                          hintText: "",
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 12, 12, 12),
                        ),
                      )),
                  const SizedBox(height: 16),
                  const Text("New Password"),
                  const SizedBox(height: 4),
                  Obx(() => FormBuilderTextField(
                        obscureText: controller.showNewPass.value,
                        name: 'newPassword',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6),
                        ]),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          hintText: "",
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 12, 12, 12),
                          suffixIcon: IconButton(
                            icon: controller.showNewPass.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              controller
                                  .showNewPass(!controller.showNewPass.value);
                            },
                          ),
                        ),
                      )),
                  const SizedBox(height: 16),
                  const Text("Confirm New Password"),
                  const SizedBox(height: 4),
                  Obx(() => FormBuilderTextField(
                        obscureText: controller.showConfirmPass.value,
                        name: 'confirmPassword',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => controller
                                    .editPasswordKey
                                    .currentState
                                    ?.fields['newPassword']
                                    ?.value !=
                                value
                            ? 'Not match new password'
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          suffixIcon: IconButton(
                            icon: controller.showConfirmPass.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              controller.showConfirmPass(
                                  !controller.showConfirmPass.value);
                            },
                          ),
                          filled: true,
                          hintText: "",
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 12, 12, 12),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:ces_app/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WrapperController wrapperController = Get.find<WrapperController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xfff05150),
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
                  controller.editProfile();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Color(0xfff05150),
                ),
                child: const Text("Save"),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: controller.editProfileKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Avatar",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xfff05150),
                            foregroundColor: Colors.white,
                            child: Icon(Icons.person),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Add photo",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Flexible(
                          child: Text(
                              "Choose the best photo! Because everyone will be able to see this photo"))
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text("Name"),
                  const SizedBox(height: 4),
                  FormBuilderTextField(
                    name: 'name',
                    initialValue: wrapperController.user.value.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: "Name",
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Phone"),
                  const SizedBox(height: 4),
                  FormBuilderTextField(
                    name: 'phone',
                    keyboardType: TextInputType.phone,
                    initialValue: wrapperController.user.value.phone,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: "Phone",
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

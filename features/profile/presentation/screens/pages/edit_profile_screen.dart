import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/helper/app_responsive/screen_size.dart';
import 'package:health_house/core/resources/assets_paths/icon_assets_paths.dart';
import 'package:health_house/core/resources/assets_paths/images_assets_paths.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/features/auth/common/widgets/auth_input_field.dart';
import 'package:health_house/features/profile/controller/profile_controller.dart';


class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    final emailController = TextEditingController(
      text: profileController.profileData.value.result?.email ?? 'N/A',
    );

    return Scaffold(
      appBar: AppBar(
        title: FigtreeText(text: 'Profile', fontWeight: FontWeight.w600, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(10),

                /// Profile Cover Photo and Details
                Column(
                  children: [
                    // Use Stack to position the image and edit button
                    Obx(() => SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        clipBehavior: Clip.none, // Allow the edit button to overflow
                        alignment: Alignment.center, // Center the image
                        children: [
                          // Profile Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: profileController.profileImage.value != null
                                ? Image.file(
                              File(profileController.profileImage.value!.path),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            )
                                : Image.asset(
                              ImagePath.instance.profileImage,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                          ),

                          // Image Picker Button (Bottom Right)
                          Positioned(
                            bottom: -5, // Adjust to position correctly
                            right: -5,  // Adjust to position correctly
                            child: GestureDetector(
                              onTap: () async {
                                await profileController.pickImage();
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.all(5.5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: ClipRRect(
                                  child: Image.asset(IconPath.instance.edit),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 10),
                  ],
                ),
                Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthInputField(
                      headerTitle: "Username",
                      hintText: "Enter your name",
                      textEditingController: profileController.usernameController..text = profileController.profileData.value.result?.fullName ?? 'N/A',

                    ),
                    AuthInputField(
                      isReadOnly: true,
                      headerTitle: "Email Address",
                      hintText: "user@gmail.com",
                      textEditingController: emailController, // Email is typically read-only
                    ),
                    Gap(sw / 1.5),
                    CustomButton(
                      title: "Save Changes",
                      onTap: () {
                        profileController.updateAccount();
                        profileController.fetchProfileData();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
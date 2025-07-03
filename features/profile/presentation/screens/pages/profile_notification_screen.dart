import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/helper/app_responsive/screen_size.dart';
import 'package:health_house/core/resources/assets_paths/icon_assets_paths.dart';
import 'package:health_house/core/resources/assets_paths/images_assets_paths.dart';
import 'package:health_house/core/widgets/custom_app_bar.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/features/profile/controller/profile_controller.dart';

class ProfileNotificationScreen extends StatelessWidget {
  ProfileNotificationScreen({super.key});

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    return Scaffold(
      appBar: AppBar(
        title: FigtreeText(text: 'Notifications', fontWeight: FontWeight.w600, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(10),

              /// Profile Cover Photo and Details
              Column(
                children: [
                  // Use Stack to position the image and edit button
                  Container(
                    height: 100,
                    width: 100,
                    child: Stack(
                      clipBehavior: Clip.none, // Allow the edit button to overflow
                      alignment: Alignment.center, // Center the image
                      children: [
                        // Profile Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
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
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Color(0xFF364352)),
                      color: const Color(0xff0C131E),
                    ),
                    child: Column(
                      children: [
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FigtreeText(
                              text: 'Cancellation',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            Transform.scale(
                              scale: 0.7, // Adjust scale to reduce size
                              child: Switch(
                                value: profileController.cancellationEnabled.value,
                                onChanged: (value) {
                                  profileController.cancellationEnabled.value = value;
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.green,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ),
                          ],
                        )),
                        Gap(5),
                        Divider(),
                        Gap(5),
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FigtreeText(
                              text: 'Notification',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            Transform.scale(
                              scale: 0.7, // Adjust scale to reduce size
                              child: Switch(
                                value: profileController.notificationEnabled.value,
                                onChanged: (value) {
                                  profileController.notificationEnabled.value = value;
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.green,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
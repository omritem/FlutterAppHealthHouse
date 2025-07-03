

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/resources/assets_paths/icon_assets_paths.dart';
import 'package:health_house/core/resources/assets_paths/images_assets_paths.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/features/community/presentation/widgets/challenges.dart';
import 'package:health_house/features/community/presentation/widgets/leaderboard.dart';
import 'package:health_house/features/profile/controller/profile_controller.dart';
import 'package:health_house/features/profile/presentation/screens/about.dart';
import 'package:health_house/features/profile/presentation/screens/badges.dart';
import 'package:health_house/features/profile/presentation/screens/my_post.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
          child: Column(
            children: [
              CustomAppBar(text: "Profile"),
              SizedBox(height: 10),

              /// Profile Cover Photo and Details
              Obx(()=> Column(
                children: [
                  // Image
                  SizedBox(
                    height: 146, // 96 (cover) + 50 (half of profile image)
                    child: Stack(
                      clipBehavior: Clip.none, // Allows overflow
                      children: [
                        // Cover Image
                        Container(
                          height: 96,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              ImagePath.instance.profileCover,
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        ),

                        // Profile Image (Centered at the bottom)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  // Name
                  FigtreeText(
                    text: profileController.profileData.value.result?.fullName ??' User Name',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          FigtreeText(
                            text: '125',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          Gap(5),
                          FigtreeText(
                            text: 'Friends',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Gap(16),
                      FigtreeText(
                        text: '|',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(16),
                      Row(
                        children: [
                          FigtreeText(
                            text: '125',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          Gap(5),
                          FigtreeText(
                            text: 'Following',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),),


              Gap(16),

              /// Tab bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff0C131E),
                  border: Border.all(width: 1, color: Color(0xff1E293B)),
                ),
                child: TabBar(
                  controller: profileController.tabController,
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff030911),
                    border: Border.all(width: 1.5, color: Color(0xff364352)),
                  ),
                  labelColor: Color(0xffF9FAFB),
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: Color(0xffF9FAFB),
                  tabs: [
                    Tab(text: 'My Post'),
                    Tab(text: 'Badges'),
                    Tab(text: 'About'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: profileController.tabController,
                  children: [MyPosts(), Badges(), AboutProfile()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

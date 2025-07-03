
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/resources/assets_paths/icon_assets_paths.dart';
import 'package:health_house/core/services/zihad/auth_services.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/features/profile/controller/profile_controller.dart';
import 'package:health_house/features/profile/presentation/widgets/about_item_card.dart';
import 'package:health_house/route/app_routes_names.dart';

class AboutProfile extends StatelessWidget {
  const AboutProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Bio
          Container(
            // height: 90,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Color(0xFF364352)),
              color: const Color(0xff0C131E),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FigtreeText(
                      text: 'Bio',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Image.asset(IconPath.instance.edit, height: 18, width: 18,),
                  ],
                ),
                Gap(10),
                FigtreeText(
                  text: 'Fitness enthusiast and health advocate. Love running and cycling on weekends.',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),

              ],
            ),
          ),
          Gap(16),

          // Status
          Container(
            // height: 90,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Color(0xFF364352)),
              color: const Color(0xff0C131E),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FigtreeText(
                  text: 'Status',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FigtreeText(
                          text: 'Total Activities',
                          color: Color(0xFF9BA4B0),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(4),
                        FigtreeText(
                          text: '250',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FigtreeText(
                          text: 'Total Distance ',
                          color: Color(0xFF9BA4B0),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(4),
                        FigtreeText(
                          text: '1,020 km',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),),
                  ],
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FigtreeText(
                          text: 'Total Points',
                          color: Color(0xFF9BA4B0),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(4),
                        FigtreeText(
                          text: '250',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FigtreeText(
                          text: 'Badges Earned ',
                          color: Color(0xFF9BA4B0),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(4),
                        FigtreeText(
                          text: '1,020 km',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),),
                  ],
                ),

              ],
            ),
          ),
          Gap(16),

          // Upgrade Premium
          InkWell(
            onTap: () => Get.toNamed(AppRoutesNames.subscriptionPlanScreen),
            child: Container(
              // height: 90,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Color(0xFF364352)),
                color: const Color(0xff0C131E),
              ),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(125),
                          color: Color(0xFFF20333),
                        ),
                        child: FigtreeText(
                          text: 'Pro',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(12),
                      FigtreeText(
                        text: 'Upgrade to Premium',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFA7AEC1), size: 20),
                    ],
                  ),
                  Gap(10),
                  FigtreeText(
                    text: 'Enjoy workout access without ads and restrictions.',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),

                ],
              ),
            ),
          ),
          Gap(16),

          // General
          Align(
            alignment: Alignment.centerLeft,
            child: FigtreeText(
              text: 'General',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(12),
          AboutItemCard(
            icon: IconPath.instance.user,
            title: 'Edit Profile',
            onTap: () => Get.toNamed(AppRoutesNames.editProfile),
          ),
          Gap(12),
          AboutItemCard(
            icon: IconPath.instance.notification,
            title: 'Notifications',
            onTap: () => Get.toNamed(AppRoutesNames.profileNotificationScreen),
          ),
          Gap(16),

          // Preferences
          Align(
            alignment: Alignment.centerLeft,
            child: FigtreeText(
              text: 'Preferencess',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(12),
          AboutItemCard(
            icon: IconPath.instance.security,
            title: 'Legal and Policies',
            onTap: () => Get.toNamed(AppRoutesNames.legalAndPoliciesScreen),
          ),
          Gap(12),
          AboutItemCard(
            icon: IconPath.instance.message,
            title: 'Help & Support',
            onTap: () => Get.toNamed(AppRoutesNames.helpAndSupportScreen),
          ),
          Gap(12),
          AboutItemCard(
            icon: IconPath.instance.logout,
            title: 'Logout',
            onTap: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  backgroundColor: Color(0xFF0C131E),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap:  () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(Icons.close_outlined, size: 24,),
                            ),
                          ),
                        ),
                        Gap(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: FigtreeText(text: 'Are you sure you want to logout?', fontWeight: FontWeight.w600, fontSize: 18, textAlign: TextAlign.center,),
                        ),

                        Gap(40),
                        InkWell(onTap: () => Navigator.pop(context),child: FigtreeText(text: 'Cancel', fontWeight: FontWeight.w600, fontSize: 15 )),
                        Gap(20),
                        InkWell( onTap: () {
                         AuthService.logoutUser();
                        },child: FigtreeText(text: 'Log Out', fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFFE50000), )),
                      ],
                    ),
                  ),
                );
              },);
            },
          ),
          Gap(12),

        ],
      ),
    );
  }
}




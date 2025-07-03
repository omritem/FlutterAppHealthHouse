import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_house/core/resources/assets_paths/svg_assets_paths.dart';

import '../../../core/app_colors/app_colors.dart';

import '../controller/nav_controller.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});
  final NavBarController controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryAppThemColor,
      body: Obx(() => controller.screens[controller.currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0C131E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeIndex,

            backgroundColor: Colors.transparent,
            selectedItemColor: Color(0xffF20333),

            unselectedItemColor: Color(0xffE5E7EB),
            selectedLabelStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              _buildNavItem(
                iconPath: SvgPath.instance.home,
                activeIconPath: SvgPath.instance.homeFill,
                label: 'Home',
              ),
              _buildNavItem(
                iconPath: SvgPath.instance.activities,
                activeIconPath: SvgPath.instance.activitiesFill,
                label: 'Activities',
              ),
              _buildNavItem(
                iconPath: SvgPath.instance.rewards,
                activeIconPath: SvgPath.instance.rewardsFill,
                label: 'Rewards',
              ),
              _buildNavItem(
                iconPath: SvgPath.instance.community,
                activeIconPath: SvgPath.instance.communityFill,
                label: 'Community',
              ),
              _buildNavItem(
                iconPath: SvgPath.instance.profile,
                activeIconPath: SvgPath.instance.profileFill,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String activeIconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(iconPath, width: 24, height: 24),
      activeIcon: SvgPicture.asset(activeIconPath, width: 24, height: 24),
      label: label,
    );
  }
}

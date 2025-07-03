import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/core/widgets/dynamic_container.dart';
import 'package:health_house/features/community/controller/challenges_controller.dart';
import 'package:health_house/features/community/presentation/widgets/daily.dart';
import 'package:health_house/features/community/presentation/widgets/quick.dart';
import 'package:health_house/features/community/presentation/widgets/team.dart';
import 'package:health_house/features/community/presentation/widgets/tiered.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/wrappers/figtree_text.dart';
import '../screens/discover_challenges_screen.dart';

class Challenges extends StatelessWidget {
  Challenges({super.key});
  final controller = Get.put(ChallengesController());
  @override
  Widget build(BuildContext context) {
    return buildBrandSection();
  }

  Widget buildBrandSection() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTabItem(index: 0, title: "Tiered", icon: IconPath1.tiered),
              SizedBox(width: 4),
              _buildTabItem(index: 1, title: "Quick", icon: IconPath1.quick),
              SizedBox(width: 4),
              _buildTabItem(index: 2, title: "Daily", icon: IconPath1.daily),
              SizedBox(width: 4),
              _buildTabItem(index: 3, title: "Team", icon: IconPath1.team),
            ],
          ),
        ),
        SizedBox(height: 20),
        Flexible(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: [Tiered(), Quick(), Daily(), Team()],
          ),
        ),
        SizedBox(height: 20),
        DynamicContainer(
          showBorder: true,
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FigtreeText(
                      text: "Discover New Challenges",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4),
                    FigtreeText(
                      text: "Join exciting challenges and earn rewards",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    title: "Explore",
                    onTap: () {
                      Get.to(() => DiscoverChallengesScreen());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTabItem({
    required int index,
    required String title,
    required String icon,
  }) {
    return InkWell(
      onTap: () => controller.changeTab(index),
      child: Obx(() {
        final isSelected = controller.selectedTab.value == index;
        return Container(
          width: 105,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Color(0xff2BA849) : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(50),
            color: isSelected
                ? Color(0xff2BA849).withAlpha(25)
                : Color(0xff0C131E),
          ),
          child: Row(
            children: [
              Image.asset(icon, width: 20, height: 20, fit: BoxFit.cover),
              SizedBox(width: 6),
              FigtreeText(
                textAlign: TextAlign.center,
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Color(0xff2BA849) : Colors.white,
              ),
            ],
          ),
        );
      }),
    );
  }
}

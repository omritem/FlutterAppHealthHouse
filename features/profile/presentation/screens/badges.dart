
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/features/profile/controller/profile_controller.dart';
import 'package:health_house/features/profile/presentation/widgets/badge_item_card.dart';

class Badges extends StatelessWidget {
  const Badges({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 12, // horizontal spacing between items
          mainAxisSpacing: 12, // vertical spacing between items
          childAspectRatio: 0.9, // width/height ratio of each item
        ),
        itemCount: profileController.badgeItemList.length,
        itemBuilder: (context, index) {
          final badge = profileController.badgeItemList[index];
          return BadgeItemCard(
            title: badge['title'],
            icon: badge['icon'],
            progressText: badge['subtitle'],
            progressValue: badge['value'],
          );
        },
      ),
    );
  }
}


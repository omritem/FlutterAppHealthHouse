import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/app_colors/app_colors.dart';
import 'package:health_house/core/widgets/custom_text_field.dart';
import 'package:health_house/features/community/presentation/screens/post_create_screen.dart';
import '../../controller/feed_controller.dart';
import '../screens/post_details_screen.dart';
import 'custom_box_widgets.dart';

class Feeds extends StatelessWidget {
  const Feeds({super.key});

  @override
  Widget build(BuildContext context) {
    final feedController = Get.put(FeedController());

    return SingleChildScrollView(
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                Get.to(() => PostCreateScreen());
              },
              child: CustomTextField(
                readonly: true,
                hintText: "What are you up to?",
                hintTextColor: AppColors.textPrimaryColor,
                containerColor: Colors.transparent,
                radius: 8,
                suffixIcon: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Column(
              children: feedController.posts.asMap().entries.map((entry) {
                final index = entry.key;
                final post = entry.value;
                return Column(
                  children: [
                    CustomBoxWidgets(
                      onShift: () {
                        Get.to(() => PostDetailsScreen());
                      },
                      postImage: post['postImage'] ?? '',
                      userName: post['userName'] ?? 'Unknown',
                      userImage: post['userImage'] ?? '',
                      description: post['description'] ?? '',
                      date: post['date'] ?? '',
                      time: post['time'] ?? '',
                      isLiked: post['isLiked'] ?? false,
                      onLikeToggle: () => feedController.toggleLike(index),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/features/community/presentation/screens/post_details_screen.dart';
import 'package:health_house/features/community/presentation/widgets/custom_box_widgets.dart';
import 'package:health_house/features/profile/controller/profile_controller.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return SingleChildScrollView(
      child: Column(
        children: [

          Obx(() => Column(
              children: profileController.posts.asMap().entries.map((entry) {
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
                      onLikeToggle: () => profileController.toggleLike(index),
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

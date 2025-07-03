import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/core/widgets/dynamic_container.dart';
import 'package:health_house/core/widgets/dynamic_progress_bar.dart';
import '../../../../core/wrappers/figtree_text.dart';
import '../../controller/challenge_controller.dart';
import 'leaderboard_screen.dart';

class ChallengesDetailsScreen extends StatelessWidget {
  const ChallengesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChallengeController controller = Get.put(ChallengeController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: FigtreeText(
          text: 'Challenge Details',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Challenge Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1544717297-fa95b6ee9643?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Challenge Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Obx(
                    () => FigtreeText(
                      text: controller.challengeTitle.value,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Challenge Goal
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Obx(
                    () => FigtreeText(
                      text: 'Goal: ${controller.challengeGoal.value}',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Points Reward
                DynamicContainer(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffFAAD14),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Obx(
                          () => FigtreeText(
                            text: '${controller.rewardPoints.value} Points',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Progress Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: DynamicContainer(
                    backgroundColor: Color(0xff0C131E),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FigtreeText(
                                text: 'Progress',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              Obx(
                                () => FigtreeText(
                                  text: controller.progressText.value,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          DynamicProgressBar(
                            value: 20,
                            progressGradient: LinearGradient(
                              colors: [Color(0xffFF97AC), Color(0xffF20333)],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Info Cards Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: DynamicContainer(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.group, color: Colors.white, size: 24),
                              SizedBox(width: 16),
                              FigtreeText(
                                text: "Rank: ${controller.userRank.value}",
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.timelapse,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 16),
                              FigtreeText(
                                text:
                                    "Time Remaining: ${controller.timeRemaining.value}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // View Leaderboard Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CustomButton(title: "Join Now", onTap: () {}),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CustomButton(
                    textColor: Color(0xff2BA849),
                    boarderColor: Color(0xff2BA849),
                    title: "View Leaderboard",
                    onTap: () {
                      Get.to(() => LeaderboardScreen());
                    },
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

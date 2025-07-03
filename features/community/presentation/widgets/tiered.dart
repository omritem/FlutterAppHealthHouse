import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/challenges_controller.dart';
import '../screens/challenges_details_screen.dart';
import 'challenge_card.dart';

class Tiered extends StatelessWidget {
  const Tiered({super.key});

  @override
  Widget build(BuildContext context) {
    final ChallengesController controller = Get.find<ChallengesController>();

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Obx(
        () => ListView.builder(
          itemCount: controller.tieredChallenges.length,
          itemBuilder: (context, index) {
            final challenge = controller.tieredChallenges[index];
            return ChallengeCard(
              image: challenge.backgroundImage,
              title: challenge.title,
              subtitle: challenge.subtitle,
              points: challenge.points,
              progress: challenge.progress,
              maxProgress: challenge.maxProgress,
              progressPercentage: challenge.progressPercentage,
              ranking: challenge.ranking,
              timeRemaining: challenge.timeRemaining,
              onTap: () {
                Get.to(() => ChallengesDetailsScreen());
              },
              value: challenge.value,
            );
          },
        ),
      ),
    );
  }
}

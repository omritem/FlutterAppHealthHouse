import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controller/challenges_controller.dart';
import 'challenge_card.dart';

class Quick extends StatelessWidget {
  const Quick({super.key});
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
              onTap: () {},
              value: challenge.value,
            );
          },
        ),
      ),
    );
  }
}

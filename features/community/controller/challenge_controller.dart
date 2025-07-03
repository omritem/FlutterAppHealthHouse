import 'package:get/get.dart';

class ChallengeController extends GetxController {
  // Challenge Details
  var challengeTitle = 'Weekly Running Challenge'.obs;
  var challengeGoal = 'Complete 28km Running'.obs;
  var rewardPoints = 1000.obs;

  // Progress Data
  var currentProgress = 15.15.obs;
  var totalTarget = 28.0.obs;
  var progressPercentage = 0.0.obs;
  var progressText = ''.obs;

  // User Stats
  var userRank = '15/100'.obs;
  var timeRemaining = '7 days'.obs;

  @override
  void onInit() {
    super.onInit();
    updateProgress();
  }

  void updateProgress() {
    progressPercentage.value = currentProgress.value / totalTarget.value;
    progressText.value = '${currentProgress.value}km / ${totalTarget.value}km';
  }

  void viewLeaderboard() {
    // Navigate to leaderboard screen
    Get.toNamed('/leaderboard');
  }

  void updateCurrentProgress(double newProgress) {
    currentProgress.value = newProgress;
    updateProgress();
  }

  void setChallengeData({
    required String title,
    required String goal,
    required int points,
    required double current,
    required double target,
    required String rank,
    required String time,
  }) {
    challengeTitle.value = title;
    challengeGoal.value = goal;
    rewardPoints.value = points;
    currentProgress.value = current;
    totalTarget.value = target;
    userRank.value = rank;
    timeRemaining.value = time;
    updateProgress();
  }
}

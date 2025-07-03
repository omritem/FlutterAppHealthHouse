class ChallengesModel {
  final String id;
  final String title;
  final String subtitle;
  final String backgroundImage;
  final int points;
  final String progress;
  final String maxProgress;
  final double progressPercentage;
  final String ranking;
  final String timeRemaining;
  final double value;

  ChallengesModel({
    required this.value,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.backgroundImage,
    required this.points,
    required this.progress,
    required this.maxProgress,
    required this.progressPercentage,
    required this.ranking,
    required this.timeRemaining,
  });
}

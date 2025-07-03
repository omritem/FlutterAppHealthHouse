

import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  var selectedPlanIndex = RxInt(1); // Default selected yearly plan (index 1)

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
  }

  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      id: 'monthly',
      title: "Monthly",
      price: "\$9.99/month",
      duration: "Duration: 1 month",
      features: const [
        "GPS Tracking",
        "Real-time Heart Rate Monitoring",
        "Leaderboards",
        "Ad-free Experience",
      ],
    ),
    SubscriptionPlan(
      id: 'yearly',
      title: "Yearly",
      price: "\$99/year",
      duration: "Duration: 12 months",
      features: const [
        "All Monthly Plan Features",
        "Save 20% (Compared to Monthly)",
        "Exclusive Rewards and Premium",
        "Challenges",
      ],
      isPopular: true,
    ),
  ];


}

class SubscriptionPlan {
  final String id;
  final String title;
  final String price;
  final String duration;
  final List<String> features;
  final bool isPopular;

  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.features,
    this.isPopular = false,
  });
}
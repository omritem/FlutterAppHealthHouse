import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';

import '../../controller/leaderboard_controller.dart';
import 'leaderboard_widget.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderboardController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FigtreeText(
            text: "Leaderboard",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8),
          LeaderboardWidget(
            title: "The Health Maximizer",
            rank: "6th",
            image:
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
            rankData: controller.rankData,
          ),
        ],
      ),
    );
  }
}

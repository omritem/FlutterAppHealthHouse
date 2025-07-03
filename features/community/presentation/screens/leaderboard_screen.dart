import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/wrappers/figtree_text.dart';
import '../../controller/leaderboard_controller.dart';
import '../widgets/leaderboard_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderboardController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: FigtreeText(
          text: 'Leaderboard',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: LeaderboardWidget(
          title: "The Health Maximizer",
          rank: "6th",
          image:
              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
          rankData: controller.rankData,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/features/community/presentation/widgets/challenges.dart';
import 'package:health_house/features/community/presentation/widgets/feeds.dart';
import 'package:health_house/features/community/presentation/widgets/leaderboard.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../controller/community_controller.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});

  final communityController = Get.put(CommunityController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
          child: Column(
            children: [
              CustomAppBar(text: "Community"),
              SizedBox(height: 12),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff0C131E),
                  border: Border.all(width: 1, color: Color(0xff1E293B)),
                ),
                child: TabBar(
                  controller: communityController.tabController,
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff030911),
                    border: Border.all(width: 1.5, color: Color(0xff364352)),
                  ),
                  labelColor: Color(0xffF9FAFB),
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: Color(0xffF9FAFB),
                  tabs: [
                    Tab(text: 'Feeds'),
                    Tab(text: 'Challenges'),
                    Tab(text: 'Leaderboard'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: communityController.tabController,
                  children: [Feeds(), Challenges(), Leaderboard()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

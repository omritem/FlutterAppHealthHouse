import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/challenges_model.dart';

class ChallengesController extends GetxController {
  var showSports = true.obs;
  var selectedSport = 'All'.obs;

  final PageController pageController = PageController();
  final RxInt selectedTab = 0.obs;

  // Sample challenge data
  final RxList<ChallengesModel> tieredChallenges = <ChallengesModel>[
    ChallengesModel(
      id: '1',
      title: 'Weekly Running Challenge',
      subtitle: 'Complete 25km this week',
      backgroundImage:
          'https://images.unsplash.com/photo-1544717297-fa95b6ee9643?w=400&h=200&fit=crop',
      points: 500,
      progress: '15.15km',
      maxProgress: '25km',
      progressPercentage: 0.606,
      ranking: '#8 of 100',
      timeRemaining: '2 days remaining',
      value: 50,
    ),
    ChallengesModel(
      id: '2',
      title: 'Strength Training Week',
      subtitle: 'Complete 5 strength sessions',
      backgroundImage:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400&h=200&fit=crop',
      points: 700,
      progress: '3',
      maxProgress: '5 sessions',
      progressPercentage: 0.6,
      ranking: '#8 of 100',
      timeRemaining: '5 days remaining',
      value: 100,
    ),
  ].obs;

  void changeTab(int tab) {
    selectedTab.value = tab;
    pageController.animateToPage(
      tab,
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeOut,
    );
  }
}

import 'package:get/get.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/activity_tracker.dart';
import 'package:health_house/features/community/presentation/screens/community_screen.dart';
import 'package:health_house/features/profile/presentation/screens/profile_screen.dart';
import 'package:health_house/features/rewards/presentation/screens/rewards_screen.dart';

import '../../Home/controller/home_controller.dart';
import '../../Home/presentation/screens/home_screen.dart';

class NavBarController extends GetxController {
  var selectedIndex = 0.obs;

  int get currentIndex => selectedIndex.value;

  List screens = [
    HomeScreen(),
    ActivityTracker(),
    RewardsScreen(),
    CommunityScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    //AuthService.init();
  }

  void changeIndex(int index) {
    if (selectedIndex.value == index) return;

    selectedIndex.value = index;

    if (index == 0) {
      // Home selected
      final homeController = Get.put(HomeController());
      homeController.createActivityIfNeeded();
    }
  }


  void backToHome() {
    changeIndex(0);
  }
}

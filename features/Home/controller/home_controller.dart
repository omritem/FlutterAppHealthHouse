import 'dart:developer' as developer;


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:health_house/core/resources/constants/api_endpoint.dart';
import 'package:health_house/core/services/zihad/auth_services.dart';
import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
import 'package:health_house/route/app_routes_names.dart';
import '../../../../../core/services/zihad/network_caller.dart';
import '../../../../../core/widgets/app_snacber.dart';
import '../../../../../core/resources/assets_paths/svg_assets_paths.dart';

import '../../health_data/get_health_data_controller.dart';

class HomeController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool showUpgrade = false.obs;
  RxBool activityCreated = false.obs;
  final GetHealthDataController healthController = Get.put(GetHealthDataController());

  @override
  void onInit() {
    super.onInit();
    createActivityIfNeeded();
  }

  void createActivityIfNeeded() async {
    if (healthController.isAuthorized.value) {
      // Check if there is an ongoing activity
      if (healthController.currentActivity.value == 'Unknown') {
        await createActivity();
      }
    } else {
      // Defer snackbar display to after build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
       developer.log('error: Health data access not authorized');
        // AppSnackBar.showError(
        //   'Please authorize health data access to track activities.',
        // );
      });
    }
  }
  Future<void> createActivity() async {
    bool dialogOpen = false;
    try {
      // Show dialog only once
      Get.dialog(
        Center(child: CircleLoader()),
        barrierDismissible: false,
      );
      dialogOpen = true;

      // Fetch the latest health data
      await healthController.syncHealthDataOnLogin();

      // Log all health data
      healthController.printAllHealthData();

      // Validate health data (allowing double values)
      final durationSeconds = healthController.activityTimeMinutes.value > 0
          ? (healthController.activityTimeMinutes.value * 60).round() // Convert to seconds
          : 0;
      final distanceKm = healthController.workoutDistance.value > 0
          ? healthController.workoutDistance.value // Use workoutDistance for accuracy
          : healthController.distanceWalkingRunning.value > 0
          ? healthController.distanceWalkingRunning.value
          : 0.0;
      final calories = healthController.activityCalories.value > 0
          ? healthController.activityCalories.value.round()
          : healthController.caloriesBurned.value > 0
          ? healthController.caloriesBurned.value.round()
          : 0;
      final averageHeartRate = healthController.heartRate.value > 0
          ? healthController.heartRate.value.round()
          : 0;

      // Allow proceeding with minimal valid data
      if (durationSeconds == 0 && distanceKm == 0.0 && calories == 0 && averageHeartRate == 0) {
        developer.log('No significant health data detected, proceeding with available data.');
      }


      // Get real start and end times from activityHistory if available
      String startTime = DateTime.now().toUtc().toIso8601String();
      String endTime = DateTime.now().toUtc().toIso8601String();
      if (healthController.activityHistory.isNotEmpty) {
        final latestActivity = healthController.activityHistory.last;
        startTime = DateTime.parse(latestActivity['startTime'] as String).toUtc().toIso8601String();
        endTime = DateTime.parse(latestActivity['endTime'] as String).toUtc().toIso8601String();
      }
      final requestBody = {
        "activity": healthController.currentActivity.value,
        "duration": durationSeconds,
        "distanceKm": distanceKm,
        "calories": calories,
        "avgHRZoneWeight": 0.5, // Moderate intensity
        "averageHeartRate": averageHeartRate,
        "effortTag": "Tempo",
        "consistencyBonus": 10.0,
        "restingHeartRate": healthController.restingHeartRate.value,
        "steps": healthController.steps.value,
        "activityTimeMinutes": healthController.activityTimeMinutes.value,
        "caloriesBurned": healthController.caloriesBurned.value,
        "startTime": startTime,
        "endTime": endTime,

      };

      developer.log('Create Activity request body: $requestBody');

      final response = await NetworkCaller().postRequest(
        ApiEndPoint.createActivity,
        body: requestBody,
        token: AuthService.token,
      );

      if (response.isSuccess) {
        if (dialogOpen && Get.isDialogOpen == true) {
          Get.back(); // Close loader
        }
        Get.toNamed(AppRoutesNames.bottomNavScreen);
        developer.log('Response: ${response.responseData}');
      } else if (response.statusCode == 400) {
        developer.log('Error: ${response.errorMessage ?? "Invalid input data"}');
        AppSnackBar.showError(response.errorMessage ?? "Please check the request payload.");
      } else {
        AppSnackBar.showError(response.errorMessage?.toString() ?? "Something went wrong.");
      }
    } catch (e) {
      developer.log('Exception: ${e.toString()}');
      AppSnackBar.showError("An error occurred: ${e.toString()}");
    } finally {
      if (dialogOpen && Get.isDialogOpen == true) {
        Get.back(); // Close dialog
      }
    }
  }

  List<Map<String, dynamic>> items = [
    {
      'title': 'Challenges',
      'subtitle': '2/3 Entered',
      'icon': SvgPath.instance.goal,
      'value': 2 / 3,
      'rank': null,
      'progressGradient': LinearGradient(
        colors: [Color(0xffFDA9C3), Color(0xffFE0037)],
      ),
    },
    {
      'title': '10,000 Steps',
      'subtitle': '1d 3h 45m',
      'icon': SvgPath.instance.steps,
      'value': 0.1,
      'rank': 'Rank #34 of 230',
      'note': '+2,000 steps could move you to Top 20!',
      'progressGradient': LinearGradient(
        colors: [Color(0xff00C9FF), Color(0xff92FE9D)],
      ),
    },
    {
      'title': 'Earn 200 Coins',
      'subtitle': '2h 16m',
      'icon': SvgPath.instance.coin,
      'value': 0.12,
      'rank': 'Rank #12 of 100',
      'progressGradient': LinearGradient(
        colors: [Color(0xff4CAF50), Color(0xff8BC34A)],
      ),
    },
  ];

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}
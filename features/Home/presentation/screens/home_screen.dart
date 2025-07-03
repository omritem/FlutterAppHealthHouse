import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_house/core/app_colors/app_colors.dart';
import 'package:health_house/core/resources/assets_paths/icon_assets_paths.dart';
import 'package:health_house/core/resources/assets_paths/images_assets_paths.dart';
import 'package:health_house/core/resources/assets_paths/svg_assets_paths.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/features/Home/controller/home_controller.dart';
import 'package:health_house/features/Home/widget/upgrade_premium_popup.dart';
import 'package:health_house/route/app_routes_names.dart';
import 'package:percent_indicator_circle/percent_indicator_circle.dart';
import '../../../../core/widgets/dynamic_container.dart';
import '../../../../core/widgets/dynamic_progress_bar.dart';
import '../../../health_data/get_health_data_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GetHealthDataController controller = Get.put
      (GetHealthDataController());
  final HomeController homeController =  Get.put
    (HomeController());

  @override
  Widget build(BuildContext context) {
// Trigger data sync when the screen builds
   // Future.microtask(() => controller.syncHealthDataOnLogin());

    return Scaffold(
      body: Obx(() =>
          Stack(
            children: [
              if (controller.isLoading.value)
                Center(child: CircularProgressIndicator())
              else
                RefreshIndicator(
                  onRefresh: () async {
                    await controller
                        .syncHealthDataOnLogin(); // Trigger data refresh
                  },
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),

                            /// Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  IconPath.instance.logoHome,
                                  width: 102,
                                  height: 40,
                                  color: AppColors.whiteColor,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      IconPath.instance.coin,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    FigtreeText(
                                      text: '504',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.deepYellow,
                                    ),
                                    const SizedBox(width: 24),
                                    DynamicContainer(
                                      isCircular: true,
                                      child: IconButton(
                                        onPressed: () => Get.toNamed(
                                            AppRoutesNames.notificationScreen),
                                        icon: Icon(
                                          Icons.notifications_none_outlined,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // /// Height and Weight Section
                            // DynamicContainer(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(16),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment
                            //           .spaceBetween,
                            //       children: [
                            //         // Column(
                            //         //   crossAxisAlignment: CrossAxisAlignment
                            //         //       .start,
                            //         //   children: [
                            //         //     FigtreeText(
                            //         //       text: 'Height',
                            //         //       fontWeight: FontWeight.w600,
                            //         //       fontSize: 16,
                            //         //       color: AppColors.whiteColor,
                            //         //     ),
                            //         //     FigtreeText(
                            //         //       text: '${(controller.height.value *
                            //         //           100).toStringAsFixed(1)} cm',
                            //         //       fontWeight: FontWeight.w600,
                            //         //       fontSize: 18,
                            //         //       color: AppColors.deepYellow,
                            //         //     ),
                            //         //   ],
                            //         // ),
                            //         Column(
                            //           crossAxisAlignment: CrossAxisAlignment
                            //               .start,
                            //           children: [
                            //             FigtreeText(
                            //               text: 'Weight',
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 16,
                            //               color: AppColors.whiteColor,
                            //             ),
                            //             FigtreeText(
                            //               text: '${controller.weight.value
                            //                   .toStringAsFixed(1)} kg',
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 18,
                            //               color: AppColors.deepYellow,
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 24),

                            /// Status Section
                            DynamicContainer(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        FigtreeText(
                                          text: 'Status ',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.whiteColor,
                                        ),
                                        FigtreeText(
                                          text: 'Gold',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.deepYellow,
                                        ),
                                        const Spacer(),
                                        FigtreeText(
                                          text: 'Next: ',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: AppColors.textGrey,
                                        ),
                                        DynamicContainer(
                                          backgroundColor: const Color(
                                              0xFF364352).withOpacity(0.40),
                                          borderRadius: 20,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: FigtreeText(
                                              text: 'Black',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    DynamicProgressBar(
                                      value: 0.7,
                                      progressGradient: LinearGradient(
                                        colors: [Colors.red, Colors.orange],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        FigtreeText(
                                          text: '500/5k pts',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                        FigtreeText(
                                          text: 'Top 10%',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                        FigtreeText(
                                          text: '~30 days to Black',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            /// Circular Progress Indicators
                            Row(
                              children: [
                                Expanded(
                                  child: DynamicContainer(
                                    showBorder: true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: PercentCircleIndicator(
                                              percent: controller.heartRate
                                                  .value / 100,
                                              progress: const LinearGradient(
                                                colors: [
                                                  Colors.orange,
                                                  Colors.red
                                                ],
                                              ),
                                              backgroundColor: const Color(
                                                  0xff364352),
                                              strokeWidth: 8,
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              FigtreeText(
                                                text: '${controller.heartRate
                                                    .value.toStringAsFixed(
                                                    1)} ',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                color: AppColors.deepYellow,
                                              ),
                                              FigtreeText(
                                                text: 'bpm',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.whiteColor,
                                              ),
                                            ],
                                          ),
                                          FigtreeText(
                                            text: 'Out of 100 Goal',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColors.textGrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: DynamicContainer(
                                    showBorder: true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: PercentCircleIndicator(
                                              percent: controller.steps.value /
                                                  8000,
                                              progress: const LinearGradient(
                                                colors: [
                                                  Colors.teal,
                                                  Colors.green
                                                ],
                                              ),
                                              backgroundColor: const Color(
                                                  0xff364352),
                                              strokeWidth: 8,
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              FigtreeText(
                                                text: '${controller.steps
                                                    .value} ',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                color: Color(0xFF2BA849),
                                              ),
                                              FigtreeText(
                                                text: 'steps',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.whiteColor,
                                              ),
                                            ],
                                          ),
                                          FigtreeText(
                                            text: 'Out of 8,000 Goal',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColors.textGrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            /// Stats Row
                            Row(
                              children: [
                                Expanded(
                                  child: DynamicContainer(
                                    showBorder: true,
                                    child: Column(
                                      spacing: 5,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: DynamicContainer(
                                            isCircular: true,
                                            backgroundColor: Color(0xff030911),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: SvgPicture.asset(
                                                SvgPath.instance.calorie,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${controller
                                                    .caloriesBurned.value
                                                    .toStringAsFixed(0)} ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.whiteColor,
                                                  fontFamily: 'Figtree',
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'kcal',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
                                                  color: Color(0xffE5E7EB),
                                                  fontFamily: 'Figtree',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        FigtreeText(
                                          text: 'Calories Burned',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: DynamicContainer(
                                    showBorder: true,
                                    child: Column(
                                      spacing: 5,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: DynamicContainer(
                                            isCircular: true,
                                            backgroundColor: Color(0xff030911),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: SvgPicture.asset(
                                                SvgPath.instance.clocks,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${controller
                                                    .activityTimeMinutes.value
                                                    .toStringAsFixed(0)} ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.whiteColor,
                                                  fontFamily: 'Figtree',
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'minutes',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
                                                  color: Color(0xffE5E7EB),
                                                  fontFamily: 'Figtree',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        FigtreeText(
                                          text: 'Activity Time',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            /// Streaks Section
                            Row(
                              children: [
                                Expanded(
                                  child: DynamicContainer(
                                    showBorder: true,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            DynamicContainer(
                                              isCircular: true,
                                              backgroundColor: AppColors
                                                  .deepYellow.withOpacity(0.10),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: SvgPicture.asset(
                                                  SvgPath.instance.coin,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                FigtreeText(
                                                  text: ' Coins Streak',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: AppColors.whiteColor,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '🔥 5/7 ',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w600,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .deepYellow,
                                                          fontFamily: 'Figtree',
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'days',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .deepYellow,
                                                          fontFamily: 'Figtree',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        FigtreeText(
                                          text: 'Days you earned any coins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                        Divider(color: Color(0xff364352)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            FigtreeText(
                                              text: '7-day streak ',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.textGrey,
                                            ),
                                            FigtreeText(
                                              text: '+100 ',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: AppColors.deepYellow,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            FigtreeText(
                                              text: 'bonus:',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.textGrey,
                                            ),
                                            const SizedBox(width: 4),
                                            FigtreeText(
                                              text: 'coins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: AppColors.deepYellow,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: DynamicContainer(
                                    showBorder: true,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            DynamicContainer(
                                              isCircular: true,
                                              backgroundColor: Color(
                                                  0xff030911),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: SvgPicture.asset(
                                                  SvgPath.instance.step,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                FigtreeText(
                                                  text: 'Steps Streak',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: AppColors.whiteColor,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '5/7 ',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w600,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .deepYellow,
                                                          fontFamily: 'Figtree',
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'days',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .deepYellow,
                                                          fontFamily: 'Figtree',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        FigtreeText(
                                          text: 'Days you hit 10,000 steps',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                        Divider(color: Color(0xff364352)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            FigtreeText(
                                              text: '7-day streak ',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.textGrey,
                                            ),
                                            FigtreeText(
                                              text: '+100 ',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Color(0xff2196F3),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            FigtreeText(
                                              text: 'bonus:',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.textGrey,
                                            ),
                                            const SizedBox(width: 4),
                                            FigtreeText(
                                              text: 'coins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Color(0xff2196F3),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            /// Challenges Section
                            Column(
                              children: [
                                _buildMainRow(
                                  homeController.items[0],
                                  homeController.toggleExpand,
                                  homeController.isExpanded.value,
                                ),
                                if (homeController.isExpanded.value)
                                  ...homeController.items
                                      .skip(1)
                                      .map((item) =>
                                      _buildExpandedContainer(item))
                                      .toList(),
                              ],
                            ),
                            const SizedBox(height: 16),

                            /// Devices Section
                            DynamicContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FigtreeText(
                                    text: 'Devices',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColors.whiteColor,
                                  ),
                                  const SizedBox(height: 16),
                                  DynamicContainer(
                                    showBorder: true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Image.asset(ImagePath.instance.watch),
                                          const SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              FigtreeText(
                                                text: 'Apple Watch',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: AppColors.whiteColor,
                                              ),
                                              FigtreeText(
                                                text: controller
                                                    .isDeviceConnected.value
                                                    ? 'Connected'
                                                    : 'Not Connected',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: controller
                                                    .isDeviceConnected.value
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              UpgradePremiumPopup(),
            ],
          )),
    );
  }

  String _getActivityImage(String activity) {
    switch (activity.toLowerCase()) {
      case 'walking':
        return SvgPath.instance.walking;
      case 'running':
        return SvgPath.instance.running;
      case 'cycling':
        return SvgPath.instance.cycling;
      default:
        return SvgPath.instance.more;
    }
  }

  Widget _buildMainRow(Map<String, dynamic> item,
      VoidCallback onTap,
      bool isExpanded,) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DynamicContainer(
        showBorder: true,
        child: Column(
          children: [
            Row(
              children: [
                DynamicContainer(
                  isCircular: true,
                  backgroundColor: const Color(0xff0e263e),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(item['icon']),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FigtreeText(
                        text: item['title'],
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.whiteColor,
                      ),
                      FigtreeText(
                        text: item['subtitle'],
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.textGrey,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons
                        .keyboard_arrow_down,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DynamicProgressBar(
              value: item['value'],
              progressGradient: item['progressGradient'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContainer(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: DynamicContainer(
        child: Column(
          children: [
            Row(
              children: [
                DynamicContainer(
                  isCircular: true,
                  backgroundColor: const Color(0xff0e263e),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(item['icon']),
                  ),
                ),
                SizedBox(width: 8),
                FigtreeText(
                  overflow: TextOverflow.ellipsis,
                  text: item['title'],
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.whiteColor,
                ),
                Spacer(),
                FigtreeText(
                  overflow: TextOverflow.ellipsis,
                  text: item['subtitle'],
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            DynamicProgressBar(
              value: item['value'],
              progressGradient: item['progressGradient'],
            ),
            const SizedBox(height: 12),
            if (item['rank'] != null)
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xff670b25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                        Icons.trending_up, size: 18, color: Color(0xffbd052b)),
                  ),
                  SizedBox(width: 8),
                  FigtreeText(
                    text: item['rank'],
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.whiteColor,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: FigtreeText(
                      text: 'Leaderboard ->',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            if (item['note'] != null)
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xff123425),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.info_outline_rounded, size: 18,
                        color: Color(0xff23883d)),
                  ),
                  SizedBox(width: 8),
                  FigtreeText(
                    text: item['note'],
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.textGrey,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
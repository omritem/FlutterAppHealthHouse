
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/app_colors/app_colors.dart';
import 'package:health_house/core/utils/constants/icon_path.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/features/Home/controller/home_controller.dart';
import 'package:health_house/features/subscription_screen/controller/subscription_controller.dart';
import 'package:health_house/route/app_routes_names.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

  final SubscriptionController controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FigtreeText(
          text: 'Packages',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.plans.length,
                  itemBuilder: (context, index) {
                    final plan = controller.plans[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Obx(() => SubscriptionPlanCard(
                        plan: plan,
                        isSelected: controller.selectedPlanIndex.value == index,
                        onTap: () => controller.selectPlan(index),
                      )),
                    );
                  },
                ),
              ),
              const Gap(16),
              CustomButton(
                title: 'Continue',
                onTap: () {
                  // final selectedIndex = controller.selectedPlanIndex.value;
                  // final selectedPlan = controller.plans[selectedIndex];
                  // Get.snackbar(
                  //   'Plan Selected',
                  //   'You selected the ${selectedPlan.title} plan',
                  //   snackPosition: SnackPosition.BOTTOM,
                  // );
                  showPaymentMethodBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Color(0xFF2BA849) : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FigtreeText(
                      text: plan.price,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF2BA849) : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: isSelected ? Color(0xFF2BA849) : Colors.grey,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                const Gap(8),
                FigtreeText(
                  text: plan.duration,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                const Gap(16),
                const FigtreeText(
                  text: 'Features:',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: plan.features
                      .map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: Color(0xFF2BA849),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FigtreeText(
                            text: feature,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xFF2BA849),
            ),
            child: FigtreeText(
              text: plan.title,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

void showPaymentMethodBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor:AppColors.secondaryAppThemColor, // Dark background
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FigtreeText(
                text: 'Payment Method',
              fontSize: 24,
              color: Color(0xff2BA849),
              fontWeight: FontWeight.w600,
            ),
           SizedBox(height: 25),
            DottedLine(
              dashLength: 8,
              dashGapLength: 8,
              lineThickness: 1.5,
              dashColor: Color(0xff9BA4B0),
            ),
            SizedBox(height: 25),
            // Stripe Option
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0C131E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xff2BA849),width: 1)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  FigtreeText(
                      text: 'Stripe',
                    fontSize: 20,
                    color: Color(0xff635bff),
                    fontWeight: FontWeight.w800,
                  ),
                  const Spacer(),
                  Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Center(
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),
            
            CustomButton(
                title: 'Confirm and Pay',
                onTap: (){
                  showPaymentSuccessfully(context);
                }),

            const SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}

void showPaymentSuccessfully(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor:AppColors.secondaryAppThemColor, // Dark background
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(IconPath1.successfullyIcon1,height: 100,width: 100),
            FigtreeText(
              text: 'Payment \nSuccessfully',
              fontSize: 32,
              color: Color(0xffF9FAFB),
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            FigtreeText(
              text: 'Your payment has been done \nsuccessfully.',
              fontSize: 14,
              color: Color(0xffF9FAFB),
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            CustomButton(
                title: 'Go To Home',
                onTap: (){
                  Get.toNamed(AppRoutesNames.bottomNavScreen);
                  final homeController = Get.find<HomeController>();
                  homeController.showUpgrade.value = false;
                }),

            const SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}


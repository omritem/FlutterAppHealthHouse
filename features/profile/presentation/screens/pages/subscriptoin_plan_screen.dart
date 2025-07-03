
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/route/app_routes_names.dart';

class SubscriptionPlanScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FigtreeText(text: 'Subscription Plan', fontWeight: FontWeight.w600, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                InkWell(
                  onTap: () => Get.toNamed(AppRoutesNames.subscriptionScreen),
                  child: Container(
                    // height: 90,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Color(0xFF364352)),
                      color: const Color(0xff0C131E),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FigtreeText(
                          text: 'Subscription Plan',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FigtreeText(
                              text: 'Monthly',
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            FigtreeText(
                              text: '\$5.99/Monthly',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Gap(15),
                        FigtreeText(
                          text: 'Next Payment: June IO, 2024',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


}
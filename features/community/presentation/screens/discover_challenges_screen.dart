import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/utils/constants/icon_path.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/core/widgets/dynamic_container.dart';
import '../../../../core/wrappers/figtree_text.dart';

class DiscoverChallengesScreen extends StatelessWidget {
  const DiscoverChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: FigtreeText(
          text: 'Discover Challenges',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 20),
            // First row - Location Based and Group Battle
            Row(
              children: [
                Expanded(
                  child: DynamicContainer(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          FigtreeText(
                            text: "Location Based",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Icon(Icons.place, color: Color(0xffF20333), size: 40),
                          SizedBox(height: 12),
                          FigtreeText(
                            text: "Near Criss Park",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          FigtreeText(
                            text: "Sustain 90 BPM",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          CustomButton(
                            title: "Battle",
                            onTap: () {},
                            color: Color(0xffF20333),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DynamicContainer(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          FigtreeText(
                            text: "Group Battle",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  DynamicContainer(
                                    showBorder: true,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 4,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '78',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  FigtreeText(
                                    text: "5 - 5",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(width: 18),

                              Column(
                                children: [
                                  DynamicContainer(
                                    showBorder: true,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 4,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '84',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  FigtreeText(
                                    text: "Winning",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          CustomButton(
                            title: "Join",
                            onTap: () {},
                            color: Color(0xff364352),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Second row - Streak Rate and Bet Potions
            Row(
              children: [
                Expanded(
                  child: DynamicContainer(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          FigtreeText(
                            text: "Streak Rate",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          SizedBox(height: 16),
                          Image.asset(IconPath1.time),
                          SizedBox(height: 12),
                          FigtreeText(
                            text: "Keep the streak going!",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          FigtreeText(
                            text: "Gunner | Mastery: 50",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          CustomButton(
                            title: "Start",
                            onTap: () {},
                            color: Color(0xffF20333),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DynamicContainer(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          FigtreeText(
                            text: "Bet Potions",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Image.asset(IconPath1.money),
                          SizedBox(height: 12),
                          FigtreeText(
                            text: "Bet & Boost",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          FigtreeText(
                            text: "Gunner | Mastery: 50",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          CustomButton(
                            title: "Place Bet",
                            onTap: () {},
                            color: Color(0xffF20333),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

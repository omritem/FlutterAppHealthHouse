import 'package:flutter/material.dart';
import 'package:health_house/core/widgets/dynamic_progress_bar.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int points;
  final String progress;
  final String maxProgress;
  final double progressPercentage;
  final String ranking;
  final String timeRemaining;
  final VoidCallback? onTap;
  final String? image;
  final double value;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.progress,
    required this.maxProgress,
    required this.progressPercentage,
    required this.ranking,
    required this.timeRemaining,
    this.onTap,
    this.image,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Image.network(
                image!,
                width: double.infinity,
                height: 185,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 100,
              left: 8,
              right: 8,
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FigtreeText(
                            text: title,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          SizedBox(height: 4),
                          FigtreeText(
                            text: subtitle,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFAAD14).withAlpha(77),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: FigtreeText(
                        text: '$points pts',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Color(0xff0C131E),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      // Progress section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FigtreeText(
                                text: '$progress / $maxProgress',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.group,
                                    color: Color(0xffF4AF23),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  FigtreeText(
                                    text: ranking,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffF4AF23),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Progress bar
                          DynamicProgressBar(
                            value: value,
                            progressGradient: LinearGradient(
                              colors: [Color(0xffFF97AC), Color(0xffF20333)],
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  FigtreeText(
                                    text: timeRemaining,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: onTap,
                                child: const Row(
                                  children: [
                                    FigtreeText(
                                      text: 'View Details',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

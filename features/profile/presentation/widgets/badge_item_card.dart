
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_house/core/widgets/dynamic_progress_bar.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';

class BadgeItemCard extends StatelessWidget {
  const BadgeItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.progressText,
    required this.progressValue,
  });

  final String icon, title, progressText;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff0C131E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(icon, height: 60),
          const Gap(6),
          Flexible(
            child: FigtreeText(
              text: title,
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          const Gap(10),
          DynamicProgressBar(
            value: progressValue,
            progressGradient: const LinearGradient(
              colors: [Color(0xffFDA9C3), Color(0xffFE0037)],
            ),
          ),
          const Gap(8),
          FigtreeText(
            text: progressText,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';

class AboutItemCard extends StatelessWidget {
  AboutItemCard({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  String title, icon;
  void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(width: 1, color: Color(0xFF364352)),
          color: const Color(0xff0C131E),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(icon, height: 24, width: 24,),
                Gap(14),
                FigtreeText(
                  text: title,
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFA7AEC1), size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
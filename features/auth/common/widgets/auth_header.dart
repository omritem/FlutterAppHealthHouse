import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/helper/app_responsive/screen_size.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
            fontSize: sw / 20,
          ),
        ),
        Gap(sw / 40),
        Text(
          subTitle,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimaryColor,
            fontSize: sw / 28,
          ),
        ),
      ],
    );
  }
}

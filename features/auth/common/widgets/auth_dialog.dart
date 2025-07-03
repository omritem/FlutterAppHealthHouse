import 'package:flutter/material.dart';
import 'package:health_house/core/resources/assets_paths/svg_assets_paths.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
import 'package:health_house/core/wrappers/svg_viewer.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/helper/app_responsive/screen_size.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    return AlertDialog(
      backgroundColor: AppColors.secondaryAppThemColor,
      content: Container(
        height: sw / 1.4,
        width: sw,
        decoration: BoxDecoration(
          color: AppColors.secondaryAppThemColor,
          borderRadius: BorderRadius.circular(sw / 30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgViewer(
              assetName: SvgPath.instance.success,
              height: sw / 4,
              width: sw / 4,
            ),
            FigtreeText(
              text: "Success",
              fontSize: sw / 16,
              color: AppColors.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
            FigtreeText(
              text: message,
              fontSize: sw / 24,
              color: AppColors.textPrimaryColor,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            CircleLoader(),
          ],
        ),
      ),
    );
  }
}

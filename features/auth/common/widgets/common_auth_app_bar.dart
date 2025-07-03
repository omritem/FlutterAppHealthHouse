import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/helper/app_responsive/screen_size.dart';

class CommonAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    return AppBar(
      title: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.appThemeColor),
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: sw / 50),
          child: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_house/core/resources/assets_paths/images_assets_paths.dart';
import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
import '../../../../core/helper/app_responsive/screen_size.dart';
import '../controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    final sh = ScreenSize.sh!.value;
    return Scaffold(
      body: Container(
        height: sh,
        width: sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.instance.splashScreen),
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(sw / 5),
            Spacer(),
            Image.asset(
              ImagePath.instance.appLogo,
              height: sw / 4.25,
              width: sw / 2,
            ),
            Spacer(),
            CircleLoader(),
            Gap(sw / 5),
          ],
        ),
      ),
    );
  }
}

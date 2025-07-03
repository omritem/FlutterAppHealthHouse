import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_house/features/Home/controller/home_controller.dart';
import 'package:health_house/route/app_routes_names.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/wrappers/figtree_text.dart';

class UpgradePremiumPopup extends StatelessWidget {
   UpgradePremiumPopup({super.key});

   final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return  Obx(() =>
    controller.showUpgrade.value ?
    Align(
      alignment: Alignment.center,
      child: Container(
        height: height*0.7,
        decoration: BoxDecoration(
          color: AppColors.secondaryAppThemColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
              children:[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: (){
                        controller.showUpgrade.value = false;
                      }, icon: Icon(Icons.close,size: 24),color: AppColors.whiteColor),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FigtreeText(
                        text: 'Upgrade to Premium',
                        color: AppColors.whiteColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 20),
                      FigtreeText(
                        text: 'Access all features with a Annual or a monthly plan.',
                        color: Color(0xffCCCCCC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 24),
                      CustomButton(
                          title: 'Upgrade Now',
                          onTap: (){
                            Get.toNamed(AppRoutesNames.subscriptionScreen);
                          }),
                      SizedBox(height: 24),
                      CustomButton(
                          title: 'Not Now',
                          color: Color(0xff364352),
                          onTap: (){
                            controller.showUpgrade.value = false;
                          }),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    ) : SizedBox()
    );
  }
}

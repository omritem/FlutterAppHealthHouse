import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_house/core/app_colors/app_colors.dart';
import 'package:health_house/core/utils/constants/icon_path.dart';
import 'package:health_house/core/widgets/custom_confirm_button.dart';
import 'package:get/get.dart';
import 'package:health_house/core/widgets/custom_input_field.dart';
import 'package:health_house/core/widgets/custom_text_field.dart';
import 'package:health_house/features/rewards/controller/Rewards_controller.dart';
import 'package:health_house/route/app_routes_names.dart';
import '../../../../core/widgets/dynamic_container.dart';
import '../../../../core/wrappers/figtree_text.dart';

class RewardsScreen extends StatelessWidget {
   RewardsScreen({super.key});

  final RewardsController controller = Get.put(RewardsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 23),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headerSection(),
                        SizedBox(height: 20),
                        FigtreeText(
                            text: 'Trending Rewards',
                          fontSize: 18,
                          color: AppColors.textSecondery,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 16),
                       _trendingSection(),
                        SizedBox(height: 32),
                        FigtreeText(
                          text: 'Gold Rewards For You',
                          fontSize: 18,
                          color: AppColors.textSecondery,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 16),
                        _goldSection()
                      ],
                    ),
                  ),
          )),
    );
  }


  Widget _headerSection(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FigtreeText(
          text: 'Store',
          fontSize: 20,
          color: AppColors.textSecondery,
          fontWeight: FontWeight.w600,
        ),
        Row(
          children: [
            SvgPicture.asset(IconPath1.coinIcon,height: 20,width: 20),
            SizedBox(width: 8),
            FigtreeText(
              text: '504',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xffFFCC29),
            ),
            SizedBox(width: 24),
            DynamicContainer(
              isCircular: true,
              child: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutesNames.notificationScreen);
                },
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _trendingSection(){
    return  ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackgroundThemColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff4A5764),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SvgPicture.asset(IconPath1.giftIcon),
                ),
                SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FigtreeText(
                      text: '15% Off PXRE GYM',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondery,

                    ),
                    SizedBox(height: 10),
                    FigtreeText(
                      text: '1500 points required',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondery,
                    ),
                  ],
                ),
                Spacer(),
                CustomConfirmButton(
                    title: 'Redeem',
                    width: 66,
                    height: 32,
                    onTap: (){
                      showRedeemPointsDialog();
                    })
              ],
            ),
          );
        });
  }

  Widget _goldSection(){
    return  ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackgroundThemColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff4A5764),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SvgPicture.asset(IconPath1.giftIcon),
                ),
                SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FigtreeText(
                      text: 'Buy 1 Get 1 Free at ',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondery,

                    ),
                    FigtreeText(
                      text: 'MyProtein',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondery,

                    ),
                    FigtreeText(
                      text: '750 points required',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondery,
                    ),
                  ],
                ),
                Spacer(),
                CustomConfirmButton(
                    title: 'Redeem',
                    width: 66,
                    height: 32,
                    onTap: (){
                      showRedeemPointsDialog();
                    })
              ],
            ),
          );
        });
  }

    void showRedeemPointsDialog(){
      Get.dialog(
        Dialog(
          backgroundColor: AppColors.secondaryAppThemColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Get.back();
                          }, icon: Icon(Icons.close,size: 24),color: AppColors.whiteColor),
                      Align(
                        alignment: Alignment.center,
                        child: FigtreeText(
                          text: 'Redeem Points',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  SvgPicture.asset(IconPath1.giftIcon,height: 98,width: 176),
                  SizedBox(height: 16),
                  FigtreeText(
                    text: '15% Off PYRE GYM',
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 16),
                  FigtreeText(
                    text: 'Enter your email to confirm',
                    color: Color(0xffCCCCCC),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 16),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: CustomTextField(
                      controller: controller.emailText,
                        hintText: 'demo@example.com'
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: CustomConfirmButton(
                        title: 'Confirm',
                        onTap: (){
                          showRewardRedeemedDialog();
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    void showRewardRedeemedDialog(){
      Get.dialog(
        Dialog(
          backgroundColor: AppColors.secondaryAppThemColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Get.back();
                            Get.back();
                          }, icon: Icon(Icons.close,size: 24),color: AppColors.whiteColor),
                      Align(
                        alignment: Alignment.center,
                        child: FigtreeText(
                          text: 'Redeem Points',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  SvgPicture.asset(IconPath1.giftIcon2,height: 180,width: 176),
                  SizedBox(height: 16),
                  FigtreeText(
                    text: 'You have successfully redeemed:',
                    color: Color(0xffCCCCCC),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 16),
                  FigtreeText(
                    text: '15% Off PYRE GYM',
                    color: Color(0xffCCCCCC),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 16),
                  FigtreeText(
                      text: 'Points used'),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: CustomConfirmButton(
                        title: 'Back to Rewards Store',
                        onTap: (){
                          Get.back();
                          Get.back();
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/app_colors/app_colors.dart';
import 'package:health_house/route/app_routes_names.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'package:health_house/features/auth/sign_in/presentations/controllers/sign_in_controller.dart';
import 'package:health_house/features/auth/sign_in/presentations/widgets/sign_in_form.dart';
import '../../../../../../core/helper/app_responsive/screen_size.dart';
import '../../../common/widgets/auth_footer.dart';
import '../../../common/widgets/auth_header.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.find<SignInController>();
    // ScreenSize.init(context);
    // final sw = ScreenSize.sw!.value;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(48),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondaryAppThemColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSignInHeader(),
                    Gap(48),
                    SignInForm(signInController: signInController),
                    Gap(30),
                    _buildForgetPassword(),
                    Gap(60),
                    _buildRememberCheck(signInController),
                    Gap(30),
                    _buildSignInFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInFooter() {
    return AuthFooter(
      promptText: "don't have an account?",
      actionText: "Sign Up",
      onTapActionText: () => Get.toNamed(AppRoutesNames.signUpScreen),
    );
  }

  Widget _buildSignInHeader() {
    return AuthHeader(
      title: "Sign in to your account",
      subTitle: "Unleash your fitness goal right way",
    );
  }

  Widget _buildRememberCheck(SignInController signInController,) {
    return Row(
      children: [
        Obx(() {
          bool isCheck = signInController.isRememberCheck.value;
          return Checkbox(
            value: signInController.isRememberCheck.value,
            onChanged: (value) => signInController.onTapRemember(),
            fillColor: WidgetStatePropertyAll(
              isCheck ? AppColors.appThemeColor : Colors.transparent,
            ),
            side: BorderSide(width: 2, color: isCheck ? Colors.transparent : AppColors.whiteColor),
          );
        }),
        FigtreeText(text: "Remember for 30 days", fontWeight: FontWeight.w500, fontSize: 14),
      ],
    );
  }

  Widget _buildForgetPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: ()=> Get.toNamed(AppRoutesNames.forgetPasswordScreen),
        child: FigtreeText(
          text: "Forgot password",
          color: AppColors.appThemeColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

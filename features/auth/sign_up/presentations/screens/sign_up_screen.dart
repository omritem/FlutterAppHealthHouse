import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/app_colors/app_colors.dart';
import 'package:health_house/route/app_routes_names.dart';
import '../../../../../../core/helper/app_responsive/screen_size.dart';
import '../../../common/widgets/auth_footer.dart';
import '../../../common/widgets/auth_header.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/sign_up_form.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.find<SignUpController>();
    // ScreenSize.init(context);
    // final sw = ScreenSize.sw!.value;

    return Scaffold(
      resizeToAvoidBottomInset: false,

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
                    _buildSignUpHeader(),
                    Gap(48),
                    SignUpForm(signUpController: signUpController),
                    Gap(16),
                    _buildSignUpFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpHeader() {
    return AuthHeader(
      title: "Sign Up to create an account",
      subTitle: "Unleash your fitness goal right way",
    );
  }

  Widget _buildSignUpFooter() {
    return AuthFooter(
      promptText: "Already have an account?",
      actionText: "Sign In",
      onTapActionText: () => Get.toNamed(AppRoutesNames.signInScreen),
    );
  }
}

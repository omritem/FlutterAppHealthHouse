import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/features/auth/sign_in/presentations/controllers/sign_in_controller.dart';
import 'package:health_house/route/app_routes_names.dart';
import '../../../../../../core/helper/app_responsive/screen_size.dart';
import '../../../common/widgets/auth_input_field.dart';
import 'package:get/get.dart';
class SignInForm extends StatelessWidget {
   SignInForm({super.key, required this.signInController});

  final SignInController signInController;
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    return Form(
      key: signInFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthInputField(
            headerTitle: "Email address",
            hintText: "Enter your email",
            textEditingController: signInController.emailAddressTEController,
          ),
          AuthInputField(
            headerTitle: "Password",
            hintText: "Enter your password",
            textEditingController: signInController.passwordTEController,
          ),
          Gap(sw / 60),
          CustomButton(
            title: "Sign Up",
            onTap:  () {
              if (signInFormKey.currentState?.validate() == true) {
                signInController.signIn();
              }
            },

          ),
        ],
      ),
    );
  }
}

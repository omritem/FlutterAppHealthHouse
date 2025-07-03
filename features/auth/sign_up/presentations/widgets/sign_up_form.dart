import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import '../../../../../../core/helper/app_responsive/screen_size.dart';
import '../../../common/widgets/auth_input_field.dart';
import '../controllers/sign_up_controller.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key, required this.signUpController});

  final SignUpController signUpController;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;

    return Form(
      key: signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthInputField(
            headerTitle: "Full Name",
            hintText: "Enter your full name",
            textEditingController: signUpController.fullNameTEController,
          ),
          AuthInputField(
            headerTitle: "Email address",
            hintText: "Enter your email",
            textEditingController: signUpController.emailAddressTEController,
          ),
          AuthInputField(
            headerTitle: "Password",
            hintText: "Enter your password",
            passwordIcon: Icons.visibility_outlined,
            textEditingController: signUpController.passwordTEController,
          ),
          Gap(sw / 60),
          CustomButton(
            title: "Sign Up",
            onTap:  () {
              if (signUpFormKey.currentState?.validate() == true) {
                signUpController.signUp();
              }
            },

          ),
        ],
      ),
    );
  }
}
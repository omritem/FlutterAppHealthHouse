import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/features/auth/common/widgets/auth_input_field.dart';
import 'package:health_house/features/auth/forget_password/controller/set_password_controller.dart';
import '../../../../../../core/helper/app_responsive/screen_size.dart';
import '../../../common/widgets/auth_header.dart';
import '../../../common/widgets/common_auth_app_bar.dart';

class SetPasswordScreen extends StatelessWidget {
   SetPasswordScreen({super.key});

   final SetPasswordController controller = Get.put(SetPasswordController());

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;

    return Scaffold(
      appBar: CommonAuthAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(sw / 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOTPHeader(),
                  Gap(sw / 10),
                  AuthInputField(
                      headerTitle: 'New password',
                      hintText: 'Enter your password',
                      textEditingController: controller.newPassText
                  ),
                  Gap(sw / 40),
                  AuthInputField(
                      headerTitle: 'Repeat',
                      hintText: 'Enter your password',
                      passwordIcon: Icons.visibility_outlined,
                      textEditingController: controller.repeatPassText
                  ),
                  CustomButton(
                    title: "Submit",
                    onTap: () {controller.resetPassword();},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPHeader() {
    return AuthHeader(
      title: "Verify your email address",
      subTitle: "We have just sent you 4 digit code via your email omotive@gmail.com",
    );
  }
}


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/route/app_routes_names.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/features/auth/common/widgets/auth_header.dart';
import 'package:health_house/features/auth/common/widgets/auth_input_field.dart';
import 'package:health_house/features/auth/common/widgets/common_auth_app_bar.dart';
import 'package:health_house/features/auth/forget_password/controller/forget_password_controller.dart';
import '../../../../../core/helper/app_responsive/screen_size.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;

    return Scaffold(
      appBar: CommonAuthAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(
              title: "Forget password?",
              subTitle: "Enter your email address for instructions",
            ),
            Gap(sw / 8),
            AuthInputField(
              headerTitle: 'Email address',
              hintText: 'omotive@gmail.com',
              textEditingController: controller.emailText,
            ),
            Gap(sw / 12),
            CustomButton(
              title: 'Send OTP',
              onTap: () {
                controller.forgetPass();
              },
            ),
          ],
        ),
      ),
    );
  }
}

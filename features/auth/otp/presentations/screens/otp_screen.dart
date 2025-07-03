import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:health_house/core/widgets/custom_button.dart';
import 'package:health_house/core/wrappers/otp_form.dart';

import 'package:health_house/features/auth/otp/presentations/controllers/otp_controller.dart';
import '../../../../../../core/helper/app_responsive/screen_size.dart';
import '../../../common/widgets/auth_footer.dart';
import '../../../common/widgets/auth_header.dart';
import '../../../common/widgets/common_auth_app_bar.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpController otpController = Get.find<OtpController>();
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;

    return Scaffold(
      appBar: CommonAuthAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(sw / 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOTPHeader(),
                Gap(sw / 10),
                OtpForm(otpController: otpController.otpTEController),
                Gap(sw / 20),
                CustomButton(
                  title: "Verify",
                  onTap: () {
                    otpController.verifyOtp();
                  },
                ),
                Gap(sw / 16),
                _buildOTPFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPFooter() {
    return AuthFooter(
      promptText: "Don't receive code?",
      actionText: "Resend Code",
      onTapActionText: () {},
      isSocialLogin: false,
    );
  }

  Widget _buildOTPHeader() {
    return AuthHeader(
      title: "Verify your email address",
      subTitle: "We have just sent you 4 digit code via your email omotive@gmail.com",
    );
  }
}


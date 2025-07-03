import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../app_colors/app_colors.dart';
import '../helper/app_responsive/screen_size.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key, required this.otpController, this.length, this.radius});

  final TextEditingController otpController;
  final int? length;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    return PinCodeTextField(
      autoDisposeControllers: false,
      length: length ?? 4,
      obscureText: false,
      animationType: AnimationType.fade,
      textInputAction: TextInputAction.next,
      textStyle: TextStyle(color: AppColors.appThemeColor),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(radius != null ? sw / radius! : sw / 24),
        fieldHeight: sw / 5,
        fieldWidth: sw / 5,
        activeFillColor: AppColors.secondaryBackgroundThemColor,
        selectedColor: AppColors.whiteColor,
        selectedFillColor: AppColors.secondaryAppThemColor,
        inactiveFillColor: AppColors.secondaryAppThemColor,
        inactiveColor: AppColors.whiteColor,
        activeColor: AppColors.appThemeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      controller: otpController,
      appContext: context,
      // validator: _otpValidation,
    );
  }
}

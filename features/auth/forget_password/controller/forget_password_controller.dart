import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/resources/constants/api_endpoint.dart';
import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
import 'package:health_house/features/auth/otp/presentations/screens/otp_screen.dart';
import 'package:health_house/route/app_routes_names.dart';

import '../../../../core/services/zihad/app_loger_helper.dart';
import '../../../../core/services/zihad/network_caller.dart';
import '../../../../core/widgets/app_snacber.dart';

class ForgetPasswordController extends GetxController {
  final emailText = TextEditingController();

  bool _isValidEmail(String email) {
    return email.isNotEmpty && GetUtils.isEmail(email);
  }

  /// Forgot password logic
  Future<void> forgetPass() async {
    String email = emailText.text.trim();

    if (!_isValidEmail(email)) {
      Get.snackbar(
        'Notice',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      Get.dialog(
        Center(
          child: CircleLoader(),
        ),
        barrierDismissible: false,
      );

      final Map<String, String> requestBody = {
        'email': email,
      };

      final response = await NetworkCaller()
          .postRequest(ApiEndPoint.forgetPassword, body: requestBody);

      if (response.isSuccess) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }

        if (response.responseData['message'] == 'User not found') {
          AppSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: 'No account found with this email address.',
          );
          log('response: ${response.responseData}');
          log('Response status: ${response.statusCode}');
          log('Response body: ${response.responseData}');
        } else {
          await Get.offAll(
                () => OtpScreen(),
            arguments: {
              'from_screen': AppRoutesNames.forgetPasswordScreen,
              "email": email,
            },
          );
          AppSnackBar.showCustomSnackBar(
            title: 'Success',
            message: 'Check your email address for the OTP.',
          );
        }
      } else {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        AppSnackBar.showCustomSnackBar(
          title: 'Error!',
          message: response.errorMessage,
        );

        /// Close the dialog after a delay to avoid indefinite loading
        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        });
      }
    } catch (error) {
      AppLoggerHelper.error('Error: $error');

      if (Get.isDialogOpen == true) {
        Get.back();
      }
      AppSnackBar.showCustomSnackBar(
        title: 'Error!',
        message: 'Something went wrong. Please try again later.',
      );
    }
  }
}

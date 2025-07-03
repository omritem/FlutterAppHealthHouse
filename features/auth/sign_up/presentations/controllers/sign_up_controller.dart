import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/resources/constants/api_endpoint.dart';
import 'package:health_house/route/app_routes_names.dart';
import '../../../../../core/services/zihad/app_loger_helper.dart';
import '../../../../../core/services/zihad/network_caller.dart';
import '../../../../../core/widgets/app_snacber.dart';
import '../../../../../core/wrappers/spinkit_circle_loader.dart';
import '../../../otp/presentations/screens/otp_screen.dart';

class SignUpController extends GetxController {
  final TextEditingController fullNameTEController = TextEditingController();
  final TextEditingController emailAddressTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  RxBool isLoading = false.obs; // Added loading state

  /// Signup function
  Future<void> signUp() async {
    // Validate inputs before proceeding
    if (fullNameTEController.text.trim().isEmpty ||
        emailAddressTEController.text.trim().isEmpty ||
        passwordTEController.text.trim().isEmpty) {
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Please fill all fields.',
      );
      return;
    }

    isLoading.value = true;
    Get.dialog(
      Center(child: CircleLoader()),
      barrierDismissible: false,
    );

    try {
      final Map<String, dynamic> requestBody = {
        "fullName": fullNameTEController.text.trim(),
        "email": emailAddressTEController.text.trim(),
        "password": passwordTEController.text.trim(),
      };

      log('SignUp Request Body: $requestBody');

      final response = await NetworkCaller().postRequest(
        ApiEndPoint.register,
        body: requestBody,
      );

      log("SignUp API Response: ${response.responseData}");

      if (response.isSuccess) {
        if (Get.isDialogOpen == true) Get.back();
        Get.to(
              () => OtpScreen(),
          arguments: {
            'formScreen': AppRoutesNames.signUpScreen,
            'email': emailAddressTEController.text.trim(),
          },
        );
      } else if (response.statusCode == 409) {
        if (Get.isDialogOpen == true) Get.back();
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: 'Email already exists. Please login or try different email.',
        );
      } else {
        if (Get.isDialogOpen == true) Get.back();
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: response.errorMessage ?? 'Something went wrong. Please try again.',
        );
      }
    } catch (e) {
      AppLoggerHelper.error('SignUp Error: $e');
      if (Get.isDialogOpen == true) Get.back();
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: e.toString().contains('TimeoutException')
            ? 'Request timed out. Check your internet connection.'
            : 'Something went wrong! Please try again.',
      );
      log("hahaha :   $e");
    } finally {
      isLoading.value = false;
      if (Get.isDialogOpen == true) Get.back();
    }
  }
}
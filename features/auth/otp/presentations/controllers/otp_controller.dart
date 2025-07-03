import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/resources/constants/api_endpoint.dart';
import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
import 'package:health_house/route/app_routes_names.dart';

import '../../../../../core/services/zihad/app_loger_helper.dart';
import '../../../../../core/services/zihad/network_caller.dart';
import '../../../../../core/widgets/app_snacber.dart';
import '../../../common/widgets/auth_dialog.dart';

class OtpController extends GetxController{
  final TextEditingController otpTEController = TextEditingController();
  final RxInt secondRemaining = 300.obs;
  RxBool isClickable = false.obs;
  String? fromScreen;
  String? email;
  Timer? _timer;


  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      email = Get.arguments["email"];
      fromScreen = Get.arguments['formScreen'];
    }
    _startCountdown();
  }


  void _startCountdown() {
    if (_timer != null && _timer!.isActive) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondRemaining.value > 0) {
        secondRemaining.value--;
      } else {
        isClickable.value = true;
        _timer?.cancel();
      }
    });
  }

  void resetTimer() {
    secondRemaining.value = 300;
    isClickable.value = false;
    _timer?.cancel(); // Cancel any existing timer
    _startCountdown();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  /// OTP Verification
  void verifyOtp() async {
    final context = Get.context;
    if (otpTEController.text.isEmpty || otpTEController.text.length != 4) {
      AppSnackBar.showCustomErrorSnackBar(
        title: "Error",
        message: 'Please enter a valid 4-digit OTP',
      );
      return;
    }

    final Map<String, dynamic> requestBody = {
      "email": email,
      'otp': otpTEController.text.toString().trim(),
    };

    try {
      Get.dialog(
        Center(
          child: CircleLoader(),
        ),
        barrierDismissible: false,
      );

      late final dynamic response;

      if (fromScreen == AppRoutesNames.signUpScreen || fromScreen == AppRoutesNames.signInScreen) {
        response = await NetworkCaller().postRequest(
          ApiEndPoint.verifySignUpOtp,
          body: requestBody,
        );
        if (response.isSuccess) {
          ///  Success — show dialog
          if (context != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AuthDialog(message: 'Your account was successfully updated.');
              },
            );

            // Wait for the dialog to be visible, then navigate
            Future.delayed(Duration(seconds: 2), () {
              if (Get.isDialogOpen ?? false) {
                Get.back(); // close dialog
              }
              Get.offAllNamed(AppRoutesNames.signInScreen);
            });
          }

          log("request $requestBody");
        } else if (response.statusCode == 408) {
          _handleError('OTP Expired');
        } else if (response.statusCode == 404) {
          _handleError('OTP doesn\'t match');
        } else {
          _handleError('OTP verification failed.');
        }
      } else {
        response = await NetworkCaller().postRequest(
          ApiEndPoint.verifyForgetPasswordOtp,
          body: requestBody,
        );

        if (response.isSuccess) {
          String? accessToken = response.responseData?['result']?['forgetToken'];
          log('Response status: ${response.statusCode}');
          log('Response body: ${response.responseData}');
          if (accessToken != null) {
            await Get.toNamed(
              AppRoutesNames.setPasswordScreen,
              arguments: {"token": accessToken},
            );
          } else {
            _handleError('Invalid OTP entered.');
          }
        } else if (response.statusCode == 408) {
          _handleError('OTP Expired');
        } else if (response.statusCode == 404) {
          _handleError('OTP doesn\'t match');
        } else {
          _handleError('OTP verification failed.');
        }
      }
    } catch (e) {
      log("OTP Verification Error: $e");
      _handleError('An unexpected error occurred. Please try again.');
    } finally {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  /// Resend OTP
  void resendOtp() async {
    secondRemaining.value = 300;
    isClickable.value = false;
    _startCountdown();

    final Map<String, dynamic> requestBody = {
      "id": email,
    };

    if (email != null) {
      try {
        Get.dialog(
          Center(child: CircleLoader()),
          barrierDismissible: false,
        );

        final response = await NetworkCaller().postRequest(
          ApiEndPoint.resendOtp,
          body: requestBody,
          //token: AuthService.token,
        );

        if (Get.isDialogOpen == true) {
          Get.back();
        }

        AppLoggerHelper.info('Resend OTP Response Status: ${response.statusCode}');
        AppLoggerHelper.info('Resend OTP Response Body: ${response.responseData}');

        if (response.isSuccess) {
          AppSnackBar.showCustomSnackBar(
            title: 'Success',
            message: 'OTP resent successfully. Please check your email.',
          );
        } else {
          /// Extract specific error message from response
          String errorMessage = response.errorMessage ??
              (response.responseData['message'] as String? ??
                  'Failed to resend OTP. Please try again.');

          /// Handle specific error cases if needed
          if (response.responseData['message'] == 'Invalid OTP') {
            errorMessage = 'Invalid OTP. Please try again.';
          } else if (response.statusCode == 429) { // Example for too many requests
            errorMessage = 'Too many requests. Please try again later.';
          }

          AppLoggerHelper.error('Resend OTP Error: $errorMessage');
          AppSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: errorMessage,
          );
        }
      } catch (e) {
        AppLoggerHelper.error('Exception in resendOtp: $e');
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: 'Something went wrong while resending OTP. Please try again.',
        );
      } finally {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
      }
    } else {
      AppLoggerHelper.error('Email is null in resendOtp');
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Failed to resend OTP. Please try again.',
      );
    }
  }



  /// error handelling
  void _handleError(String errorMessage) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    AppSnackBar.showCustomErrorSnackBar(
      title: "Error",
      message: errorMessage,
    );
  }

}

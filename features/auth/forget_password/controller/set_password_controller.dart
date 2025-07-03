import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/form_validations.dart';
import '../../../../core/resources/constants/api_endpoint.dart';
import '../../../../core/services/zihad/app_loger_helper.dart';
import '../../../../core/services/zihad/network_caller.dart';
import '../../../../core/widgets/app_snacber.dart';
import '../../../../core/wrappers/spinkit_circle_loader.dart';
import '../../../../route/app_routes_names.dart';
import '../../common/widgets/auth_dialog.dart';

class SetPasswordController extends GetxController{

  final newPassText = TextEditingController();
  final repeatPassText = TextEditingController();
  final isLoading = false.obs;

  String? token;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      token = Get.arguments["token"];
    }
  }

  /// reset Passwor
  Future<void> resetPassword() async {
    final context = Get.context;
    if (newPassText.text != repeatPassText.text) {
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Passwords do not match.',
      );
      return;
    }

    final passwordError = FormValidations.validatePassword(
      newPassText.text.trim(),
    );
    if (passwordError != null) {
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: passwordError,
      );
      return;
    }
    final Map<String, dynamic> requestBody = {
      'newPassword': newPassText.text.trim(),
    };
    try {
      Get.dialog(
        Center(
            child: CircleLoader()),

        barrierDismissible: false,
      );
      String? accessToken = token;
      final response = await NetworkCaller().patchRequest(
        ApiEndPoint.resetPassword,
        body: requestBody,
        token: accessToken,
      );
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      Get.back(); // Close loader
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
      } else {
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: response.errorMessage,
        );
      }

      /// Close the dialog after some time (to prevent indefinite loading)
      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    } catch (e) {
      AppLoggerHelper.error('Error: $e');
    } finally {
      isLoading.value = false;
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }
}
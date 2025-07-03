import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/resources/constants/api_endpoint.dart';
import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
import 'package:health_house/route/app_routes_names.dart';

import '../../../../../core/services/zihad/auth_services.dart';
import '../../../../../core/services/zihad/network_caller.dart';
import '../../../../../core/widgets/app_snacber.dart';

class SignInController extends GetxController{
  final TextEditingController emailAddressTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  //final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  RxBool isRememberCheck = false.obs;

  void onTapRemember() {
    isRememberCheck.value = !isRememberCheck.value;
  }

  NetworkCaller networkCaller = NetworkCaller();
  String fcmToken = '';




  /// fcm notification
  // Future<void> initializeFCM() async {
  //   try {
  //     await FirebaseMessaging.instance.requestPermission(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //     String? token = await FirebaseMessaging.instance.getToken();
  //     if (token == null || token.isEmpty) {
  //       throw Exception('FCM token is empty');
  //     }
  //     log("********************************FCM Token: $token");
  //     fcmToken = token;
  //   } catch (e) {
  //     log("Error getting FCM Token: $e");
  //   }
  // }


  Future<void> signIn() async {
    try {
      Get.dialog(
        Center(child: CircleLoader()),
        barrierDismissible: false,
      );
      final requestBody = {
        "email": emailAddressTEController.text.toString().trim(),
        "password": passwordTEController.text.toString().trim(),
        "fcmToken": fcmToken,
      };

      final response = await NetworkCaller().postRequest(
        ApiEndPoint.login,
        body: requestBody,
      );

      log('the request body is $requestBody');

      if (response.isSuccess) {
        String token = response.responseData['result']['accessToken'];

        if (token.isNotEmpty) {
          await AuthService.saveToken(token);
          Get.offAllNamed(AppRoutesNames.bottomNavScreen);
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          log('the response is ${response.responseData}');
          log('the token is $token');
        }
      } else if (response.statusCode == 401) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        AppSnackBar.showError("Invalid credentials");
      } else if (response.statusCode == 308) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        String email = response.responseData['result']['email'];
        log('log use: $email');
        Get.offAllNamed(
          AppRoutesNames.otpScreen,
          arguments: {'formScreen': AppRoutesNames.signInScreen, 'email': email},
        );
        AppSnackBar.showError(response.errorMessage);
      } else {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        AppSnackBar.showError(response.errorMessage);
      }
    } catch (e) {
      log('the exception is ${e.toString()}');
    } finally {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }
}

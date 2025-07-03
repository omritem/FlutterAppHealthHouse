// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:health_house/core/resources/constants/api_endpoint.dart';
// import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
// import 'package:health_house/route/app_routes_names.dart';
//
// import '../../../../core/services/zihad/network_caller.dart';
// import '../../../../core/widgets/app_snacber.dart';
//
// class ForgetOtpController extends GetxController{
//
//   final otpTEController = TextEditingController();
//   final TextEditingController emailTEController = TextEditingController();
//
//   Future<void> sendOtpToEmail() async {
//     Get.dialog(
//       Center(child: CircleLoader()),
//       barrierDismissible: false,
//     );
//
//     try {
//       final requestBody = {"email": emailTEController.text.trim()};
//
//       final response = await NetworkCaller().postRequest(
//         ApiEndPoint.forgetPassword,
//         body: requestBody,
//       );
//
//       if (response.isSuccess) {
//         String? email = emailTEController.text.trim();
//         if (kDebugMode) {
//           print("The user email is $email");
//         }
//         if (Get.isDialogOpen == true) {
//           Get.back();
//         }
//         Get.toNamed(
//           AppRoutesNames.otpScreen,
//           arguments: {
//             "email": email,
//             "formScreen": AppRoutesNames.forgetPasswordScreen,
//             //"email": emailTEController.text.toString(),
//           },
//         );
//       } else {
//         AppSnackBar.showError("Not a registered email!!");
//       }
//     } catch (e) {
//       AppSnackBar.showError(e.toString());
//     }
//   }
// }

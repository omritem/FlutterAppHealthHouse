// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:health_house/route/app_routes_names.dart';
// import 'package:health_house/features/auth/forget_password/presentations/screens/forget_otp_screen.dart';
// import 'package:health_house/features/auth/forget_password/presentations/screens/forget_password_screen.dart';
// import 'package:health_house/features/auth/forget_password/presentations/screens/set_password_screen.dart';
// import 'package:health_house/features/auth/otp/presentations/screens/otp_screen.dart';
// import 'package:health_house/features/auth/sign_in/presentations/screens/sign_in_screen.dart';
// import 'package:health_house/features/onboarding/presentations/screens/onboarding_screen.dart';
// import 'package:health_house/features/splash/presentations/screens/splash_screen.dart';
// import '../features/auth/sign_up/presentations/screens/sign_up_screen.dart';
// import '../features/bottom_nav/screen/bottom_nav_screen.dart';

// class AppPages {
//   static List<GetPage<dynamic>> appPages() {
//     return [
//       _getPages(name: AppRoutesNames.splashScreen, page: SplashScreen(),),
//       _getPages(name: AppRoutesNames.onboardingScreen, page: OnboardingScreen(),),
//       _getPages(name: AppRoutesNames.signUpScreen, page: SignUpScreen(),),
//       _getPages(name: AppRoutesNames.signInScreen, page: SignInScreen(),),
//       _getPages(name: AppRoutesNames.otpScreen, page: OtpScreen(),),
//       _getPages(name: AppRoutesNames.forgetPasswordScreen, page: ForgetPasswordScreen(),),

//       _getPages(name: AppRoutesNames.forgetOtpScreen, page: ForgetOtpScreen(),),
//       _getPages(name: AppRoutesNames.setPasswordScreen, page: SetPasswordScreen(),),

//       _getPages(name: AppRoutesNames.bottomNavScreen, page: BottomNavScreen()),
//       _getPages(name: AppRoutesNames.bottomNavScreen, page: BottomNavScreen()),

//     ];
//   }

//   static GetPage<dynamic> _getPages({
//     required String name,
//     required Widget page,
//   }) => GetPage(
//     name: name,
//     page: ()=> page,
//   );
// }
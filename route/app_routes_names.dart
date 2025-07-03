import 'package:get/get.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/activity_details_screen.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/activity_tracker.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/cycling_number.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/cycling_screen.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/cycling_time.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/cycling_time_screen_2.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/my_exercises.dart';
import 'package:health_house/features/Activity_flow/presentations/screen/your_all_activity_screen.dart';
import 'package:health_house/features/auth/forget_password/presentations/screens/forget_otp_screen.dart';
import 'package:health_house/features/auth/forget_password/presentations/screens/forget_password_screen.dart';
import 'package:health_house/features/auth/forget_password/presentations/screens/set_password_screen.dart';
import 'package:health_house/features/auth/otp/presentations/screens/otp_screen.dart';
import 'package:health_house/features/auth/sign_in/presentations/screens/sign_in_screen.dart';
import 'package:health_house/features/notification_screen/presentaion/screen/notification_screnn.dart';
import 'package:health_house/features/onboarding/presentations/screens/onboarding_screen.dart';
import 'package:health_house/features/profile/presentation/screens/pages/edit_profile_screen.dart';
import 'package:health_house/features/profile/presentation/screens/pages/help_and_support_screen.dart';
import 'package:health_house/features/profile/presentation/screens/pages/legal_and_policies_screen.dart';
import 'package:health_house/features/profile/presentation/screens/pages/profile_notification_screen.dart';
import 'package:health_house/features/profile/presentation/screens/pages/subscriptoin_plan_screen.dart';
import 'package:health_house/features/splash/presentations/screens/splash_screen.dart';
import 'package:health_house/features/subscription_screen/presentation/screen/subscription_screen.dart';
import '../features/auth/sign_up/presentations/screens/sign_up_screen.dart';
import '../features/bottom_nav/screen/bottom_nav_screen.dart';

class AppRoutesNames {
  // Added by Shahriar
  static const String splashScreen = "/";
  static const String onboardingScreen = "/onboarding_screen";
  static const String signUpScreen = "/signup_screen";
  static const String signInScreen = "/sign_in_screen";
  static const String otpScreen = "/otp_screen";
  static const String forgetPasswordScreen = "/forget_password_screen";
  static const String forgetOtpScreen = "/forgetOtpScreen";
  static const String setPasswordScreen = "/setPasswordScreen";
  static const String yourAllActivityScreen = "/yourAllActivityScreen";
  static const String bottomNavScreen = "/bottomNavScreen";

  static const String activityTracker = "/activityTracker";
  static const String myExercises = "/myExercises";
  static const String cyclingScreen = "/cyclingScreen";
  static const String cyclingNumber = "/cyclingNumber";
  static const String cyclingTime = "/cyclingTime";

  // Added by Shahriar
  static const String cyclingTimeScreen2 = "/cyclingTimeScreen2";
  static const String activityDetailsScreen = "/activityDetailsScreen";

  /// Profile
  static const String editProfile = "/editProfile";
  static const String profileNotificationScreen = "/profileNotificationScreen";
  static const String helpAndSupportScreen = "/helpAndSupportScreen";
  static const String legalAndPoliciesScreen = "/legalAndPoliciesScreen";
  static const String subscriptionPlanScreen = "/subscriptionPlanScreen";
  static const String subscriptionScreen = "/subscriptionScreen";

  static const String notificationScreen = "/notificationScreen";

  static List<GetPage> routes = [
    // Added by Shahriar
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: signInScreen, page: () => SignInScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: forgetPasswordScreen, page: () => ForgetPasswordScreen()),
    GetPage(name: forgetOtpScreen, page: () => ForgetOtpScreen()),
    GetPage(name: setPasswordScreen, page: () => SetPasswordScreen()),
    GetPage(name: bottomNavScreen, page: () => BottomNavScreen()),
    GetPage(name: yourAllActivityScreen, page: () => YourAllActivityScreen()),

    GetPage(name: activityTracker, page: () => ActivityTracker()),
    GetPage(name: myExercises, page: () => MyExercises()),
    GetPage(name: cyclingScreen, page: () => CyclingScreen()),
    GetPage(name: cyclingNumber, page: () => CyclingNumber()),
    GetPage(name: cyclingTime, page: () => CyclingTime()),

    // Added bu Shahriar
    GetPage(name: cyclingTimeScreen2, page: () => CyclingTimeScreen2()),
    GetPage(name: activityDetailsScreen, page: () => ActivityDetailsScreen()),

    /// Profile
    GetPage(name: editProfile, page: () => EditProfileScreen()),
    GetPage(name: profileNotificationScreen, page: () => ProfileNotificationScreen()),
    GetPage(name: helpAndSupportScreen, page: () => HelpAndSupportScreen()),
    GetPage(name: legalAndPoliciesScreen, page: () => LegalAndPoliciesScreen()),
    GetPage(name: subscriptionPlanScreen, page: () => SubscriptionPlanScreen()),
    GetPage(name: subscriptionScreen, page: () => SubscriptionScreen()),

    GetPage(name: notificationScreen, page: () => NotificationScreen()),
  ];
}

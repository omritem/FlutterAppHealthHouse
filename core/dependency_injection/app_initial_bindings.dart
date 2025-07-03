import 'package:get/get.dart';
import 'package:health_house/core/helper/app_responsive/screen_size.dart';
import 'package:health_house/features/Activity_flow/controller/my_exercises_controller.dart';
import 'package:health_house/features/auth/sign_in/presentations/controllers/sign_in_controller.dart';
import 'package:health_house/features/onboarding/presentations/controllers/onboarding_controller.dart';
import 'package:health_house/features/profile/controller/profile_controller.dart';
import 'package:health_house/features/splash/presentations/controllers/splash_controller.dart';
import '../../features/auth/otp/presentations/controllers/otp_controller.dart';
import '../../features/auth/sign_up/presentations/controllers/sign_up_controller.dart';

class AppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScreenSize(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => OtpController(), fenix: true);
    Get.lazyPut(() => MyExercisesController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: false);
  }
}

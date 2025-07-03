import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/app_colors/app_colors.dart';
import 'package:health_house/route/app_routes_names.dart';
import 'package:health_house/core/helper/app_responsive/screen_size.dart';
import '../core/dependency_injection/app_initial_bindings.dart';

class HealthHouse extends StatelessWidget {
  const HealthHouse({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      initialBinding: AppInitialBindings(),
      initialRoute: AppRoutesNames.splashScreen,
       getPages: AppRoutesNames.routes,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.appBarBackgroundThemColor,
          ),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStatePropertyAll(AppColors.whiteColor),),
      ),
    );
  }
}

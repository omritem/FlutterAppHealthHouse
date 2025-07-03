import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../app_colors/app_colors.dart';

class CircleLoader extends StatelessWidget {
  const CircleLoader({super.key,  this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(color: color ?? AppColors.appThemeColor, size: 50.0,);
  }
}

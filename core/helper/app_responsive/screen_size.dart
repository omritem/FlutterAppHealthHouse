import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSize extends GetxController {
  static Rx<MediaQueryData>? _mq;
  static Rx<double>? sw;
  static Rx<double>? sh;

  static void init(BuildContext context) {
    _mq = MediaQuery.of(context).obs;
    sw = _mq!.value.size.width.obs;
    sh = _mq!.value.size.height.obs;

    _mq!.listen((data) {
      sw?.value = data.size.width;
      sh?.value = data.size.height;
    });

    debugPrint("Initial Width: ${sw?.value}");
    debugPrint("Initial Height: ${sh?.value}");
  }

  double get width => sw?.value ?? 0.0;
  double get height => sh?.value ?? 0.0;
  Orientation get orientation => _mq?.value.orientation ?? Orientation.portrait;
}
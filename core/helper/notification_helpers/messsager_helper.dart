import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageHelper {
  MessageHelper._privateConstructor();

  static final MessageHelper _instance = MessageHelper._privateConstructor();

  factory MessageHelper() {
    return _instance;
  }

  void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: const Color(0xFF00A8CC),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
}

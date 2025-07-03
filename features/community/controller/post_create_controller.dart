import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/route/app_routes_names.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../bottom_nav/controller/nav_controller.dart';

class PostCreateController extends GetxController {
  final TextEditingController postTextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Observable variables
  var userName = 'David Resan'.obs;
  var userProfileImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60'
          .obs;
  var selectedImages = <File>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize user data
    loadUserData();
  }

  void loadUserData() {
    // Load user data from your data source
    // This is just example data
    userName.value = 'David Resan';
    userProfileImage.value =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60';
  }

  Future<void> openCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        selectedImages.add(File(photo.path));
        Get.snackbar(
          'Success',
          'Photo captured successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture photo: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> openGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(imageQuality: 80);

      if (images.isNotEmpty) {
        for (var image in images) {
          selectedImages.add(File(image.path));
        }
        Get.snackbar(
          'Success',
          '${images.length} image(s) selected',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to select images: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      Get.snackbar(
        'Success',
        'Image removed successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  Future<void> createPost() async {
    if (postTextController.text.trim().isEmpty && selectedImages.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add some content to your post',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Clear text and images after successful post
      postTextController.clear();
      selectedImages.clear();

      final bottomNavController = Get.find<NavBarController>();
      bottomNavController.changeIndex(3);
      Get.toNamed(AppRoutesNames.bottomNavScreen);
      Get.snackbar(
        'Success',
        'Post has been created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create post: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    postTextController.dispose();
    super.onClose();
  }
}

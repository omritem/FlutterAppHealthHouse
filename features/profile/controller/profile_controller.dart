
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/resources/assets_paths/icon_assets_paths.dart';
import 'package:health_house/core/resources/assets_paths/images_assets_paths.dart';
import 'package:health_house/core/resources/constants/api_endpoint.dart';
import 'package:health_house/core/wrappers/spinkit_circle_loader.dart';
import 'package:health_house/route/app_routes_names.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../core/services/zihad/app_loger_helper.dart';
import '../../../core/services/zihad/auth_services.dart';
import '../../../core/services/zihad/network_caller.dart';
import '../../../core/widgets/app_snacber.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final TextEditingController usernameController = TextEditingController();

  RxBool cancellationEnabled = true.obs;
  RxBool notificationEnabled = true.obs;
  final profileData = ProfileModel().obs;
  var isLoading = false.obs;
  final profileImage = Rxn<XFile>();
  RxString imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    fetchPosts();
    fetchProfileData();
  }

  var posts = <Map<String, dynamic>>[].obs;
/// get profile data
  Future<void> fetchProfileData() async {
    isLoading.value = true;
    try {
      final response = await NetworkCaller().getRequest(
        ApiEndPoint.getUserProfile,
        token: AuthService.token,
      );
      if (response.isSuccess && response.responseData != null) {
        profileData.value = ProfileModel.fromJson(response.responseData);
        usernameController.text = profileData.value.result?.fullName ?? 'N/A';
      } else {
        AppLoggerHelper.error('Failed to fetch profile data: ${response.errorMessage}');
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: 'Failed to load profile data.',
        );
      }
    } catch (e) {
      AppLoggerHelper.error('Error fetching profile data: $e');
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'An error occurred while fetching profile data.',
      );
    } finally {
      isLoading.value = false;
    }
  }
/// pick image from gallery
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImage.value = pickedFile;
        imagePath.value = pickedFile.path;
      } else {
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: 'No hay ninguna imagen seleccionada',
        );
      }
    } catch (e) {
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'No se pudo seleccionar la imagen: $e',
      );
    }
  }
/// update profile
  Future<void> updateAccount() async {
    if (isLoading.value) return; // Prevent multiple updates

    isLoading.value = true;
    Get.dialog(
      Center(child: CircleLoader()),
      barrierDismissible: false,
    );

    try {
      Map<String, dynamic> requestBody = {
        "fullName": usernameController.text.trim().isNotEmpty
            ? usernameController.text.trim()
            : profileData.value.result?.fullName ?? 'N/A',
      };

      final success = await _sendRequestWithHeadersAndImages(
        ApiEndPoint.updateProfile,
        requestBody,
        profileImage.value?.path, // Use profileImage.path if available
        AuthService.token,
      );

      if (success) {
        await fetchProfileData(); // Refresh profile data
        AppSnackBar.showCustomSnackBar(
          title: 'Éxito',
          message: '¡Perfil actualizado exitosamente!',
        );
      } else {
        throw Exception('Update request failed.');
      }
    } catch (e) {
      log('Error Updating User: $e');
      AppSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: e.toString().contains('Connection reset')
            ? 'Unable to connect to the server. Please check your network or try again later.'
            : 'Failed to update profile: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  Future<bool> _sendRequestWithHeadersAndImages(
      String url,
      Map<String, dynamic> body,
      String? imagePath,
      String? token,
      ) async {
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll({
        'Authorization': token ?? '',
        'Content-Type': 'multipart/form-data', // Explicitly set content type
      });

      // Encode body as JSON string
      request.fields['bodyData'] = jsonEncode(body);
      log('Request Body: ${request.fields}');

      // Add image if available
      if (imagePath != null && File(imagePath).existsSync()) {
        log('Attaching image: $imagePath');
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage',
          imagePath,
        ));
      } else {
        log('No image attached or image path invalid.');
      }

      log('Request URL: $url');
      log('Request Headers: ${request.headers}');

      final response = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('The request timed out.');
        },
      );

      final responseString = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseString');

      Map<String, dynamic>? jsonResponse;
      try {
        jsonResponse = jsonDecode(responseString);
      } catch (e) {
        log('JSON Parsing Error: $e');
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: 'Respuesta no válida del servidor.',
        );
        return false;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        log('Error response: ${jsonResponse?['message']}');
        AppSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: jsonResponse?['message'] ??
              'Failed to update profile. Status: ${response.statusCode}',
        );
        return false;
      }
    } catch (e) {
      log('Request Error: $e');
      return false;
    }
  }

  void fetchPosts() {
    posts.addAll([
      {
        'userName': 'John Doe',
        'userImage':
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'description':
        'Qorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'date': 'April 06, 2025',
        'time': '6:20 pm',
        'postImage': ImagePath.instance.graph,
        'isLiked': true,
      },
      {
        'userName': 'Jane Smith',
        'userImage':
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
        'date': 'April 05, 2025',
        'time': '4:15 pm',
        'postImage': ImagePath.instance.graph,
        'isLiked': false,
      },
      {
        'userName': 'Mike Johnson',
        'userImage':
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'description':
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
        'date': 'April 04, 2025',
        'time': '2:30 pm',
        'postImage': ImagePath.instance.graph,
        'isLiked': false,
      },
    ]);
  }

  void toggleLike(int index) {
    posts[index]['isLiked'] = !(posts[index]['isLiked'] ?? false);
    posts.refresh(); // Notify UI to rebuild with updated like state
  }

  /// Badge Item List
  List<Map<String, dynamic>> badgeItemList = [
    {
      'title': 'Weekly Streak',
      'subtitle': '4/7 Days',
      'icon': IconPath.instance.weeklyStreak,
      'value': 4 / 7,
    },
    {
      'title': 'Challenge Champ',
      'subtitle': '0/10 Challenge',
      'icon': IconPath.instance.challengeChamp,
      'value': 3 / 8,
    },
    {
      'title': 'Point Collector',
      'subtitle': '3,250/5,000',
      'icon': IconPath.instance.pointCollector,
      'value': 3 / 8,
    },
    {
      'title': 'Arena Survivor',
      'subtitle': '0/10 Challenge',
      'icon': IconPath.instance.arenaSurvivor,
      'value': 3 / 8,
    },
    {
      'title': 'Speedster',
      'subtitle': '8/20 Miles',
      'icon': IconPath.instance.speedster,
      'value': 3 / 8,
    },
    {
      'title': 'Night Owl',
      'subtitle': '2/5 Activities',
      'icon': IconPath.instance.nightOwl,
      'value': 3 / 8,
    },
    {
      'title': 'Trailblazer',
      'subtitle': '0/3 Trails',
      'icon': IconPath.instance.trailblazer,
      'value': 3 / 8,
    },
    {
      'title': 'Early Bird ',
      'subtitle': '1/3 Mornings',
      'icon': IconPath.instance.earlyBird,
      'value': 3 / 8,
    },
  ];

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
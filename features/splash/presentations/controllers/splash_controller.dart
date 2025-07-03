import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_house/core/services/zihad/auth_services.dart';
import 'package:health_house/core/services/zihad/network_caller.dart';
import 'package:health_house/route/app_routes_names.dart';
import 'package:health_house/core/resources/constants/api_endpoint.dart'; // Assume this exists

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    await AuthService.init();
    bool hasToken = AuthService.hasToken();

    /// Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        developer.log("Location permission denied");
        _navigateBasedOnToken(hasToken);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      developer.log("Location permission denied forever");
      _navigateBasedOnToken(hasToken);
      return;
    }

    /// Get current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      developer.log("Location fetched - Lat: ${position.latitude}, Lon: ${position.longitude}");

      /// Send location to backend
      await _sendLocationToBackend(position.latitude, position.longitude);
    } catch (e) {
      developer.log("Error fetching location: $e");
    }

    _navigateBasedOnToken(hasToken);
  }
  /// Send location to backend function
  Future<void> _sendLocationToBackend(double latitude, double longitude) async {
    try {
      final requestBody = {
        "latitude": latitude,
        "longitude": longitude,
      };

      developer.log("Sending location request body: $requestBody");

      final response = await NetworkCaller().patchRequest(
        ApiEndPoint.updateLocation,
        body: requestBody,
        token: AuthService.token,
      );

      if (response.isSuccess) {
        developer.log("Location sent successfully: ${response.responseData}");
      } else {
        developer.log("Failed to send location: ${response.errorMessage}");
      }
    } catch (e) {
      developer.log("Exception in sending location: $e");
    }
  }

  void _navigateBasedOnToken(bool hasToken) {
    if (hasToken) {
      Get.offAllNamed(AppRoutesNames.bottomNavScreen);
    } else {
      Get.offAllNamed(AppRoutesNames.onboardingScreen);
    }
  }
}
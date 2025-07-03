import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_house/app/health_house.dart';
import 'core/services/debug_services/debug_service.dart';
import 'core/services/zihad/auth_services.dart';
import 'core/widgets/global_error_widget.dart';

void main() async {
  runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await AuthService.init();
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };

      ErrorWidget.builder = (FlutterErrorDetails details) {
        return const GlobalErrorWidget();
      };

      await GetStorage.init();
      runApp(HealthHouse());
    },
        (error, stack) {
      DebugServices().logError('Uncaught Error: $error');
      DebugServices().logError('Stack trace: $stack');
    },
  );
}
  
import 'dart:async';
import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class GetHealthDataController extends GetxController {
  final Health health = Health();
  RxBool isAuthorized = false.obs;
  RxBool isExpanded = false.obs;
  RxBool isLoading = false.obs;
  RxBool showUpgrade = false.obs;
  RxBool isDeviceConnected = false.obs;

  /// Reactive variables for all health data types
  RxInt steps = 0.obs;
  RxDouble heartRate = 0.0.obs;
  RxDouble caloriesBurned = 0.0.obs;
  RxDouble activityTimeMinutes = 0.0.obs;
  RxString currentActivity = "Unknown".obs;
  RxDouble height = 0.0.obs;
  RxDouble weight = 0.0.obs;
  RxDouble bloodGlucose = 0.0.obs;
  RxDouble bloodOxygen = 0.0.obs;
  RxDouble bloodPressureSystolic = 0.0.obs;
  RxDouble bloodPressureDiastolic = 0.0.obs;
  RxDouble bodyFatPercentage = 0.0.obs;
  RxDouble bodyMassIndex = 0.0.obs;
  RxDouble bodyTemperature = 0.0.obs;
  RxDouble restingHeartRate = 0.0.obs;
  RxDouble respiratoryRate = 0.0.obs;
  RxInt flightsClimbed = 0.obs;
  RxDouble distanceWalkingRunning = 0.0.obs;
  RxDouble waterIntake = 0.0.obs;
  RxInt sleepAsleepMinutes = 0.obs;
  RxInt sleepAwakeMinutes = 0.obs;
  RxInt sleepDeepMinutes = 0.obs;
  RxInt sleepLightMinutes = 0.obs;
  RxInt sleepRemMinutes = 0.obs;
  RxDouble waistCircumference = 0.0.obs;
  RxDouble leanBodyMass = 0.0.obs;
  RxDouble walkingSpeed = 0.0.obs;
  RxInt uvIndex = 0.obs;
  RxDouble insulinDelivery = 0.0.obs;
  RxString menstruationFlow = "".obs;
  RxDouble waterTemperature = 0.0.obs;
  RxDouble underwaterDepth = 0.0.obs;
  RxInt appleMoveTime = 0.obs;
  RxInt appleStandHour = 0.obs;
  RxDouble heartRateVariabilityRmssd = 0.0.obs;
  RxDouble heartRateVariabilitySdnn = 0.0.obs;
  RxList<Map<String, dynamic>> activityHistory = <Map<String, dynamic>>[].obs;
  RxDouble activityCalories = 0.0.obs;
  RxDouble workoutDistance = 0.0.obs;

  // Define all supported health data types
  final List<HealthDataType> dataTypes = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.EXERCISE_TIME,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.WORKOUT,
    HealthDataType.HEIGHT,
    HealthDataType.WEIGHT,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BODY_FAT_PERCENTAGE,
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.BODY_TEMPERATURE,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.RESPIRATORY_RATE,
    HealthDataType.FLIGHTS_CLIMBED,
    HealthDataType.WATER,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_DEEP,
    HealthDataType.SLEEP_LIGHT,
    HealthDataType.SLEEP_REM,
    HealthDataType.WAIST_CIRCUMFERENCE,
    HealthDataType.LEAN_BODY_MASS,
    HealthDataType.WALKING_SPEED,
    HealthDataType.UV_INDEX,
    HealthDataType.INSULIN_DELIVERY,
    HealthDataType.MENSTRUATION_FLOW,
    HealthDataType.WATER_TEMPERATURE,
    HealthDataType.UNDERWATER_DEPTH,
    HealthDataType.APPLE_MOVE_TIME,
    HealthDataType.APPLE_STAND_HOUR,

  ];

  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    showUpgrade.value = true;
    configureHealth();
    _startPeriodicRefresh();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  /// Configure the health plugin
  Future<void> configureHealth() async {
    try {
      developer.log("Configuring Health plugin...");
      await health.configure();
      developer.log("Health plugin configured successfully.");

      bool isAvailable = await health.isHealthConnectAvailable() || !GetPlatform.isAndroid;
      developer.log("Health platform available: $isAvailable");
      if (!isAvailable && GetPlatform.isAndroid) {
        developer.log("Health Connect not available, prompting installation...");
        await health.installHealthConnect();
        return;
      }

      await requestPermissions();
      await syncHealthDataOnLogin(); // Call sync on initial configuration
    } catch (e) {
      developer.log("Error in configureHealth: $e");
    }
  }

  /// Request permissions for health data
  Future<void> requestPermissions() async {
    developer.log("Requesting activity recognition permission...");
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions = await health.hasPermissions(dataTypes);
    developer.log("Has permissions: $hasPermissions");
    if (hasPermissions == null || !hasPermissions) {
      try {
        developer.log("Requesting authorization for data types: $dataTypes");
        isAuthorized.value = await health.requestAuthorization(dataTypes);
        developer.log("Authorization result: ${isAuthorized.value}");
        if (isAuthorized.value) {
          await health.requestHealthDataHistoryAuthorization();
          if (GetPlatform.isAndroid) {
            await health.requestHealthDataInBackgroundAuthorization();
          }
        }
      } catch (e) {
        developer.log("Error requesting permissions: $e");
        isAuthorized.value = false;
      }
    } else {
      isAuthorized.value = true;
      developer.log("Permissions already granted.");
    }
  }

  /// Sync health data on login or home screen access
  Future<void> syncHealthDataOnLogin() async {
    developer.log("Syncing health data on login or home screen access...");
    await fetchHealthData();
    printAllHealthData(); // Log the fetched data
  }

  /// Fetch all health data from Apple Health or Health Connect
  Future<void> fetchHealthData() async {
    if (!isAuthorized.value) {
      developer.log("Not authorized, requesting permissions...");
      await requestPermissions();
      if (!isAuthorized.value) return;
    }

    isLoading.value = true;
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    developer.log("Fetching data from $midnight to $now");

    try {
      /// Fetch total steps separately for accuracy
      int? totalSteps = await health.getTotalStepsInInterval(midnight, now);
      steps.value = totalSteps ?? 0;
      developer.log("Steps fetched: $totalSteps");

      /// Estimate distance from steps if no distance data
      if (steps.value > 0 && distanceWalkingRunning.value == 0.0) {
        distanceWalkingRunning.value = steps.value * 0.000762; // Approx 0.762m per step
      }

      /// Fetch health data with filtering for automatic entries
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: dataTypes,
        startTime: midnight,
        endTime: now,
        recordingMethodsToFilter: [RecordingMethod.automatic],
      );
      healthData = health.removeDuplicates(healthData);
      developer.log("Total health data points fetched: ${healthData.length}");

      /// Process workout data for activity history
      List<HealthDataPoint> workoutData = await health.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: midnight,
        endTime: now,
      );
      activityHistory.clear();
      workoutDistance.value = 0.0;
      if (workoutData.isNotEmpty) {
        for (var workout in workoutData) {
          var activityType = workout.metadata?['workout_activity_type'];
          String activityName = "Unknown";
          switch (activityType) {
            case 'HKWorkoutActivityTypeWalking':
              activityName = "Walking";
              break;
            case 'HKWorkoutActivityTypeRunning':
              activityName = "Running";
              break;
            case 'HKWorkoutActivityTypeCycling':
              activityName = "Cycling";
              break;
          }
          var calories = workout.value is NumericHealthValue
              ? (workout.value as NumericHealthValue).numericValue.toDouble()
              : (workout.workoutSummary?.totalEnergyBurned as NumericHealthValue?)?.numericValue.toDouble() ?? 0.0;
          var distance = workout.workoutSummary?.totalDistance != null
              ? (workout.workoutSummary!.totalDistance as NumericHealthValue).numericValue.toDouble() / 1000
              : 0.0;
          activityHistory.add({
            'activity': activityName,
            'startTime': workout.dateFrom.toLocal().toString(),
            'endTime': workout.dateTo.toLocal().toString(),
            'calories': calories,
            'distance': distance,
          });
        }
        if (activityHistory.isNotEmpty) {
          currentActivity.value = activityHistory.last['activity'];
          activityCalories.value = activityHistory.map((e) => e['calories'] as double).reduce((a, b) => a + b);
          activityTimeMinutes.value = activityHistory.map((e) => (DateTime.parse(e['endTime']).difference(DateTime.parse(e['startTime'])).inMinutes).toDouble()).reduce((a, b) => a + b);
          workoutDistance.value = activityHistory.map((e) => e['distance'] as double).reduce((a, b) => a + b);
        }
      }

      /// Process other health data
      for (var data in healthData) {
        switch (data.type) {
          case HealthDataType.HEART_RATE:
            var heartRateValues = healthData
                .where((d) => d.type == HealthDataType.HEART_RATE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (heartRateValues.isNotEmpty) {
              heartRate.value = heartRateValues.reduce((a, b) => a + b) / heartRateValues.length;
            }
            break;
          case HealthDataType.ACTIVE_ENERGY_BURNED:
            var caloriesValues = healthData
                .where((d) => d.type == HealthDataType.ACTIVE_ENERGY_BURNED)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (caloriesValues.isNotEmpty) {
              caloriesBurned.value = caloriesValues.reduce((a, b) => a + b) / caloriesValues.length;
            }
            break;
          case HealthDataType.EXERCISE_TIME:
            var activityTimeValues = healthData
                .where((d) => d.type == HealthDataType.EXERCISE_TIME)
                .map((d) => ((d.dateTo.millisecondsSinceEpoch - d.dateFrom.millisecondsSinceEpoch) / (1000 * 60)).round());
            if (activityTimeValues.isNotEmpty) {
              activityTimeMinutes.value = (activityTimeValues.reduce((a, b) => a + b) ~/ activityTimeValues.length).toDouble();
            }
            break;
          case HealthDataType.DISTANCE_WALKING_RUNNING:
            var distanceValues = healthData
                .where((d) => d.type == HealthDataType.DISTANCE_WALKING_RUNNING)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (distanceValues.isNotEmpty) {
              distanceWalkingRunning.value = distanceValues.reduce((a, b) => a + b) / 1000;
            }
            break;
          case HealthDataType.HEIGHT:
            var heightValues = healthData
                .where((d) => d.type == HealthDataType.HEIGHT)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (heightValues.isNotEmpty) {
              height.value = heightValues.last;
            }
            break;
          case HealthDataType.WEIGHT:
            var weightValues = healthData
                .where((d) => d.type == HealthDataType.WEIGHT)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (weightValues.isNotEmpty) {
              weight.value = weightValues.last;
            }
            break;
          case HealthDataType.BLOOD_GLUCOSE:
            var glucoseValues = healthData
                .where((d) => d.type == HealthDataType.BLOOD_GLUCOSE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (glucoseValues.isNotEmpty) {
              bloodGlucose.value = glucoseValues.last;
            }
            break;
          case HealthDataType.BLOOD_OXYGEN:
            var oxygenValues = healthData
                .where((d) => d.type == HealthDataType.BLOOD_OXYGEN)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (oxygenValues.isNotEmpty) {
              bloodOxygen.value = oxygenValues.last;
            }
            break;
          case HealthDataType.BLOOD_PRESSURE_DIASTOLIC:
            var diastolicValues = healthData
                .where((d) => d.type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (diastolicValues.isNotEmpty) {
              bloodPressureDiastolic.value = diastolicValues.last;
            }
            break;
          case HealthDataType.BLOOD_PRESSURE_SYSTOLIC:
            var systolicValues = healthData
                .where((d) => d.type == HealthDataType.BLOOD_PRESSURE_SYSTOLIC)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (systolicValues.isNotEmpty) {
              bloodPressureSystolic.value = systolicValues.last;
            }
            break;
          case HealthDataType.BODY_FAT_PERCENTAGE:
            var fatValues = healthData
                .where((d) => d.type == HealthDataType.BODY_FAT_PERCENTAGE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (fatValues.isNotEmpty) {
              bodyFatPercentage.value = fatValues.last;
            }
            break;
          case HealthDataType.BODY_MASS_INDEX:
            var bmiValues = healthData
                .where((d) => d.type == HealthDataType.BODY_MASS_INDEX)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (bmiValues.isNotEmpty) {
              bodyMassIndex.value = bmiValues.last;
            }
            break;
          case HealthDataType.BODY_TEMPERATURE:
            var tempValues = healthData
                .where((d) => d.type == HealthDataType.BODY_TEMPERATURE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (tempValues.isNotEmpty) {
              bodyTemperature.value = tempValues.last;
            }
            break;
          case HealthDataType.RESTING_HEART_RATE:
            var restingValues = healthData
                .where((d) => d.type == HealthDataType.RESTING_HEART_RATE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (restingValues.isNotEmpty) {
              restingHeartRate.value = restingValues.last;
            }
            break;
          case HealthDataType.RESPIRATORY_RATE:
            var respValues = healthData
                .where((d) => d.type == HealthDataType.RESPIRATORY_RATE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (respValues.isNotEmpty) {
              respiratoryRate.value = respValues.last;
            }
            break;
          case HealthDataType.FLIGHTS_CLIMBED:
            var flightValues = healthData
                .where((d) => d.type == HealthDataType.FLIGHTS_CLIMBED)
                .map((d) => (d.value as NumericHealthValue).numericValue.round());
            if (flightValues.isNotEmpty) {
              flightsClimbed.value = flightValues.reduce((a, b) => a + b);
            }
            break;
          case HealthDataType.WATER:
            var waterValues = healthData
                .where((d) => d.type == HealthDataType.WATER)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (waterValues.isNotEmpty) {
              waterIntake.value = waterValues.reduce((a, b) => a + b);
            }
            break;
          case HealthDataType.SLEEP_ASLEEP:
            var asleepValues = healthData
                .where((d) => d.type == HealthDataType.SLEEP_ASLEEP)
                .map((d) => ((d.dateTo.millisecondsSinceEpoch - d.dateFrom.millisecondsSinceEpoch) / (1000 * 60)).round());
            if (asleepValues.isNotEmpty) {
              sleepAsleepMinutes.value = asleepValues.reduce((a, b) => a + b);
            }
            break;
          case HealthDataType.SLEEP_AWAKE:
            var awakeValues = healthData
                .where((d) => d.type == HealthDataType.SLEEP_ASLEEP)
                .map((d) => ((d.dateTo.millisecondsSinceEpoch - d.dateFrom.millisecondsSinceEpoch) / (1000 * 60)).round());
            if (awakeValues.isNotEmpty) {
              sleepAwakeMinutes.value = awakeValues.reduce((a, b) => a + b);
            }
            break;
          case HealthDataType.SLEEP_DEEP:
            var deepValues = healthData
                .where((d) => d.type == HealthDataType.SLEEP_DEEP)
                .map((d) => ((d.dateTo.millisecondsSinceEpoch - d.dateFrom.millisecondsSinceEpoch) / (1000 * 60)).round());
            if (deepValues.isNotEmpty) {
              sleepDeepMinutes.value = deepValues.reduce((a, b) => a + b);
            }
            break;
          case HealthDataType.SLEEP_LIGHT:
            var lightValues = healthData
                .where((d) => d.type == HealthDataType.SLEEP_LIGHT)
                .map((d) => ((d.dateTo.millisecondsSinceEpoch - d.dateFrom.millisecondsSinceEpoch) / (1000 * 60)).round());
            if (lightValues.isNotEmpty) {
              sleepLightMinutes.value = lightValues.reduce((a, b) => a + b);
            }
            break;
          case HealthDataType.SLEEP_REM:
            var remValues = healthData
                .where((d) => d.type == HealthDataType.SLEEP_REM)
                .map((d) => ((d.dateTo.millisecondsSinceEpoch - d.dateFrom.millisecondsSinceEpoch) / (1000 * 60)).round());
            if (remValues.isNotEmpty) {
              sleepRemMinutes.value = remValues.reduce((a, b) => a + b);
            }
            break;
          case HealthDataType.WAIST_CIRCUMFERENCE:
            var waistValues = healthData
                .where((d) => d.type == HealthDataType.WAIST_CIRCUMFERENCE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (waistValues.isNotEmpty) {
              waistCircumference.value = waistValues.last;
            }
            break;
          case HealthDataType.LEAN_BODY_MASS:
            var leanValues = healthData
                .where((d) => d.type == HealthDataType.LEAN_BODY_MASS)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (leanValues.isNotEmpty) {
              leanBodyMass.value = leanValues.last;
            }
            break;
          case HealthDataType.WALKING_SPEED:
            var speedValues = healthData
                .where((d) => d.type == HealthDataType.WALKING_SPEED)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (speedValues.isNotEmpty) {
              walkingSpeed.value = speedValues.last;
            }
            break;
          case HealthDataType.UV_INDEX:
            var uvValues = healthData
                .where((d) => d.type == HealthDataType.UV_INDEX)
                .map((d) => (d.value as NumericHealthValue).numericValue.round());
            if (uvValues.isNotEmpty) {
              uvIndex.value = uvValues.last;
            }
            break;
          case HealthDataType.INSULIN_DELIVERY:
            var insulinValues = healthData
                .where((d) => d.type == HealthDataType.INSULIN_DELIVERY)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (insulinValues.isNotEmpty) {
              insulinDelivery.value = insulinValues.last;
            }
            break;
          case HealthDataType.MENSTRUATION_FLOW:
            var flowValues = healthData
                .where((d) => d.type == HealthDataType.MENSTRUATION_FLOW)
                .map((d) => d.metadata?['menstruation_flow'] ?? "Unspecified");
            if (flowValues.isNotEmpty) {
              menstruationFlow.value = flowValues.last;
            }
            break;
          case HealthDataType.WATER_TEMPERATURE:
            var tempValues = healthData
                .where((d) => d.type == HealthDataType.WATER_TEMPERATURE)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (tempValues.isNotEmpty) {
              waterTemperature.value = tempValues.last;
            }
            break;
          case HealthDataType.UNDERWATER_DEPTH:
            var depthValues = healthData
                .where((d) => d.type == HealthDataType.UNDERWATER_DEPTH)
                .map((d) => (d.value as NumericHealthValue).numericValue.toDouble());
            if (depthValues.isNotEmpty) {
              underwaterDepth.value = depthValues.last;
            }
            break;
          case HealthDataType.APPLE_MOVE_TIME:
            var moveValues = healthData
                .where((d) => d.type == HealthDataType.APPLE_MOVE_TIME)
                .map((d) => (d.value as NumericHealthValue).numericValue.round());
            if (moveValues.isNotEmpty) {
              appleMoveTime.value = moveValues.last;
            }
            break;
          case HealthDataType.APPLE_STAND_HOUR:
            var standValues = healthData
                .where((d) => d.type == HealthDataType.APPLE_STAND_HOUR)
                .map((d) => (d.value as NumericHealthValue).numericValue.round());
            if (standValues.isNotEmpty) {
              appleStandHour.value = standValues.last;
            }
            break;

          default:
            developer.log("Unhandled HealthDataType: ${data.type}");
            break;
        }
      }

      updateDeviceConnectionStatus();
    } catch (e) {
      developer.log("Error fetching health data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Start periodic refresh for real-time updates
  void _startPeriodicRefresh() {
    if (isAuthorized.value) {
      _refreshTimer = Timer.periodic(Duration(minutes: 1), (timer) async {
        developer.log("Periodic health data refresh at ${DateTime.now()}");
        await fetchHealthData();
        printAllHealthData(); // Log data during periodic refresh
      });
    }
  }

  /// Refresh health data manually
  void refreshData() {
    fetchHealthData();
    printAllHealthData(); // Log data during manual refresh
  }

  /// Update device connection status based on fetched data
  void updateDeviceConnectionStatus() {
    bool dataAvailable = steps.value > 0 ||
        heartRate.value > 0 ||
        caloriesBurned.value > 0 ||
        activityTimeMinutes.value > 0 ||
        height.value > 0 ||
        weight.value > 0 ||
        bloodGlucose.value > 0 ||
        bloodOxygen.value > 0 ||
        bloodPressureSystolic.value > 0 ||
        bloodPressureDiastolic.value > 0 ||
        bodyFatPercentage.value > 0 ||
        bodyMassIndex.value > 0 ||
        bodyTemperature.value > 0 ||
        restingHeartRate.value > 0 ||
        respiratoryRate.value > 0 ||
        flightsClimbed.value > 0 ||
        distanceWalkingRunning.value > 0 ||
        waterIntake.value > 0 ||
        sleepAsleepMinutes.value > 0 ||
        sleepAwakeMinutes.value > 0 ||
        sleepDeepMinutes.value > 0 ||
        sleepLightMinutes.value > 0 ||
        sleepRemMinutes.value > 0 ||
        activityCalories.value > 0 ||
        waistCircumference.value > 0 ||
        leanBodyMass.value > 0 ||
        walkingSpeed.value > 0 ||
        uvIndex.value > 0 ||
        insulinDelivery.value > 0 ||
        underwaterDepth.value > 0 ||
        appleMoveTime.value > 0 ||
        appleStandHour.value > 0 ||
        heartRateVariabilityRmssd.value > 0 ||
        heartRateVariabilitySdnn.value > 0;
    isDeviceConnected.value = isAuthorized.value && dataAvailable;
    developer.log("Device connection status updated: ${isDeviceConnected.value}, Data available: $dataAvailable");
  }

  /// Print all health data stored in reactive variables
  void printAllHealthData() {
    developer.log("=== Health Data ===");
    developer.log("Authorization Status: ${isAuthorized.value}");
    developer.log("Device Connected: ${isDeviceConnected.value}");
    developer.log("Steps: ${steps.value} steps");
    developer.log("Heart Rate: ${heartRate.value} bpm");
    developer.log("Calories Burned: ${caloriesBurned.value} kcal");
    developer.log("Activity Time: ${activityTimeMinutes.value} minutes");
    developer.log("Current Activity: ${currentActivity.value}");
    developer.log("Height: ${height.value} meters");
    developer.log("Weight: ${weight.value} kg");
    developer.log("Blood Glucose: ${bloodGlucose.value} mg/dL");
    developer.log("Blood Oxygen: ${bloodOxygen.value}%");
    developer.log("Blood Pressure Systolic: ${bloodPressureSystolic.value} mmHg");
    developer.log("Blood Pressure Diastolic: ${bloodPressureDiastolic.value} mmHg");
    developer.log("Body Fat Percentage: ${bodyFatPercentage.value}%");
    developer.log("Body Mass Index: ${bodyMassIndex.value}");
    developer.log("Body Temperature: ${bodyTemperature.value} °C");
    developer.log("Resting Heart Rate: ${restingHeartRate.value} bpm");
    developer.log("Respiratory Rate: ${respiratoryRate.value} breaths/min");
    developer.log("Flights Climbed: ${flightsClimbed.value} flights");
    developer.log("Distance Walking/Running: ${distanceWalkingRunning.value} km");
    developer.log("Water Intake: ${waterIntake.value} liters");
    developer.log("Sleep Asleep: ${sleepAsleepMinutes.value} minutes");
    developer.log("Sleep Awake: ${sleepAwakeMinutes.value} minutes");
    developer.log("Sleep Deep: ${sleepDeepMinutes.value} minutes");
    developer.log("Sleep Light: ${sleepLightMinutes.value} minutes");
    developer.log("Sleep REM: ${sleepRemMinutes.value} minutes");
    developer.log("Waist Circumference: ${waistCircumference.value} meters");
    developer.log("Lean Body Mass: ${leanBodyMass.value} kg");
    developer.log("Walking Speed: ${walkingSpeed.value} m/s");
    developer.log("UV Index: ${uvIndex.value}");
    developer.log("Insulin Delivery: ${insulinDelivery.value} IU");
    developer.log("Menstruation Flow: ${menstruationFlow.value}");
    developer.log("Water Temperature: ${waterTemperature.value} °C");
    developer.log("Underwater Depth: ${underwaterDepth.value} meters");
    developer.log("Apple Move Time: ${appleMoveTime.value} seconds");
    developer.log("Apple Stand Hour: ${appleStandHour.value} hours");
    developer.log("Heart Rate Variability RMSSD: ${heartRateVariabilityRmssd.value} ms");
    developer.log("Heart Rate Variability SDNN: ${heartRateVariabilitySdnn.value} ms");
    developer.log("Activity Calories: ${activityCalories.value} kcal");
    developer.log("Workout Distance: ${workoutDistance.value} km");

    developer.log("=== Activity History ===");
    if (activityHistory.isEmpty) {
      developer.log("No activity history available.");
    } else {
      for (var activity in activityHistory) {
        developer.log("Activity: ${activity['activity']}");
        developer.log("Start Time: ${activity['startTime']}");
        developer.log("End Time: ${activity['endTime']}");
        developer.log("Calories: ${activity['calories']} kcal");
        developer.log("Distance: ${activity['distance']} km");
        developer.log("---");
      }
    }
    developer.log("=================");
  }
}
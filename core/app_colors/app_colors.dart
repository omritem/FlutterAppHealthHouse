import 'package:flutter/material.dart';

class AppColors {
  AppColors._internal();

  static final AppColors _instance = AppColors._internal();

  static AppColors get instance => _instance;

  static final Color _appThemColor = Color(0xFFF20333);
  static final Color _secondaryAppThemColor = Color(0xFF0C131E);
  static final Color _appBarBackgroundThemColor = Color(0xFF030911);
  static final Color _secondaryBackgroundThemColor = Color(0xFF0C131E);
  static final Color _scaffoldBackgroundColor = Color(0xFF030911);
  static final Color _textPrimaryColor = Color(0xFFFFFFFF);
  static final Color _textSecondaryColor = Color(0xFF636F85);
  static final Color _lightGrey = Color(0xFF636F85);
  static final Color _textGrey = Color(0xFF9BA4B0);
  static final Color _blackColor = Color(0xFF000000);
  static final Color _whiteColor = Color(0xFFFFFFFF);
  static final Color _deepOrange = Color(0xFFFF9800);
  static final Color _deepYellow = Color(0xFFFFCC29);
  static final Color _amberColor = Colors.amber;

  static final Color _textSecondery = Color(0xffF9FAFB);

  static Color get appThemeColor => _appThemColor;
  static Color get secondaryAppThemColor => _secondaryAppThemColor;
  static Color get appBarBackgroundThemColor => _appBarBackgroundThemColor;
  static Color get secondaryBackgroundThemColor => _secondaryBackgroundThemColor;
  static Color get scaffoldBackgroundColor => _scaffoldBackgroundColor;
  static Color get textPrimaryColor => _textPrimaryColor;
  static Color get textSecondaryColor => _textSecondaryColor;
  static Color get lightGrey => _lightGrey;
  static Color get textGrey => _textGrey;
  static Color get blackColor => _blackColor;
  static Color get whiteColor => _whiteColor;
  static Color get deepOrange => _deepOrange;
  static Color get deepYellow => _deepYellow;
  static Color get amberColor => _amberColor;
  static Color get textSecondery => _textSecondery;
}
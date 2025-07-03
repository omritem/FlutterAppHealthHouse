import 'assets_base_paths.dart';

class IconPath{
  IconPath._internal();

  static final IconPath _instance = IconPath._internal();

  static IconPath get instance => _instance;

  String get _iconsAssetsPaths => "${AssetsBasePaths.basePaths}/icons";

String get appLogo => "$_iconsAssetsPaths/app_logo.png";



/// added by zihad
  String get coin => "$_iconsAssetsPaths/coin.png";
  String get logoHome => "$_iconsAssetsPaths/logoHome.png";


  /// Adding by Tuhin for Profile
  String get edit => "$_iconsAssetsPaths/edit.png";
  String get arenaSurvivor => "$_iconsAssetsPaths/arena-survivor.png";
  String get challengeChamp => "$_iconsAssetsPaths/challenge-champ.png";
  String get earlyBird => "$_iconsAssetsPaths/early-bird.png";
  String get nightOwl => "$_iconsAssetsPaths/night_owl.png";
  String get pointCollector => "$_iconsAssetsPaths/point-collector.png";
  String get speedster => "$_iconsAssetsPaths/speedster.png";
  String get trailblazer => "$_iconsAssetsPaths/trailblazer.png";
  String get weeklyStreak => "$_iconsAssetsPaths/weekly-streak.png";
  String get logout => "$_iconsAssetsPaths/logout.png";
  String get message => "$_iconsAssetsPaths/message-question.png";
  String get security => "$_iconsAssetsPaths/security.png";
  String get user => "$_iconsAssetsPaths/user.png";
  String get notification => "$_iconsAssetsPaths/notification.png";
  String get alarmClock => "$_iconsAssetsPaths/alarm-clock.png";
}
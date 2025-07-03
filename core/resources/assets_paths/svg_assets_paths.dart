import 'assets_base_paths.dart';

class SvgPath {
  SvgPath._internal();

  static final SvgPath _instance = SvgPath._internal();

  static SvgPath get instance => _instance;

  String get _svgAssetsPaths => "${AssetsBasePaths.basePaths}/svg_files";

  String get splashScreen => "$_svgAssetsPaths/splash_screen.svg";
  String get google => "$_svgAssetsPaths/google.svg";
  String get success => "$_svgAssetsPaths/success.svg";
  String get activities => "$_svgAssetsPaths/activities.svg";
  String get activitiesFill => "$_svgAssetsPaths/activities_fill.svg";
  String get community => "$_svgAssetsPaths/community.svg";
  String get communityFill => "$_svgAssetsPaths/comunity_fill.svg";
  String get home => "$_svgAssetsPaths/home.svg";
  String get homeFill => "$_svgAssetsPaths/home_fill.svg";
  String get profile => "$_svgAssetsPaths/profile.svg";
  String get profileFill => "$_svgAssetsPaths/profilr_fill.svg";
  String get rewards => "$_svgAssetsPaths/rewards.svg";
  String get rewardsFill => "$_svgAssetsPaths/rewards_fill.svg";

  String get cycling => "$_svgAssetsPaths/cycling.svg";
  String get walking => "$_svgAssetsPaths/walking.svg";
  String get running => "$_svgAssetsPaths/running.svg";
  String get more => "$_svgAssetsPaths/more.svg";
  
  String get steps => "$_svgAssetsPaths/steps.svg";
  String get time => "$_svgAssetsPaths/time.svg";
  String get calorie => "$_svgAssetsPaths/calorie.svg";
  String get coin => "$_svgAssetsPaths/coin.svg";
  
  
  String get bikeIndoor => "$_svgAssetsPaths/bike_indoor.svg";
  String get treadmill => "$_svgAssetsPaths/treadmill.svg";
  String get trackRun => "$_svgAssetsPaths/track_run.svg";
  String get riking => "$_svgAssetsPaths/riking.svg";
  String get runningCoach => "$_svgAssetsPaths/running_coach.svg";
  
  String get favoriteFill => "$_svgAssetsPaths/favorite_fill.svg";
  String get favoriteBlank => "$_svgAssetsPaths/favorite_blank.svg";
  String get hiking => "$_svgAssetsPaths/hiking.svg";

  String get heartBeet => "$_svgAssetsPaths/heart_beet.svg";
  String get one => "$_svgAssetsPaths/one.svg";
  
  
  String get calories => "$_svgAssetsPaths/calories.svg";
  String get step => "$_svgAssetsPaths/step.svg";
  String get speed => "$_svgAssetsPaths/speed.svg";
  String get pace => "$_svgAssetsPaths/pace.svg";
  String get distance => "$_svgAssetsPaths/distance.svg";
  String get clocks => "$_svgAssetsPaths/clocks.svg";

  // Added by shahriar
  String get notificationICon => "$_svgAssetsPaths/notificationICon.svg";
  String get loveIcon => "$_svgAssetsPaths/loveIcon.svg";


  /// added by Zihad

  String get logoHome => "$_svgAssetsPaths/logoHome.svg";
  String get goal => "$_svgAssetsPaths/goal.svg";
  String get watch => "$_svgAssetsPaths/watch.svg";
}

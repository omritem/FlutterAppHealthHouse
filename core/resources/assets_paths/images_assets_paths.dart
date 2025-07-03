import 'assets_base_paths.dart';

class ImagePath {
  ImagePath._internal();

  static final ImagePath _instance = ImagePath._internal();

  static ImagePath get instance => _instance;

  String get _imagesAssetsPaths => "${AssetsBasePaths.basePaths}/images";

  String get splashScreen => "$_imagesAssetsPaths/splash_screen.png";

  String get appLogo => "$_imagesAssetsPaths/app_logo.png";
  String get onboardingImage1 => "$_imagesAssetsPaths/onboarding_image1.png";
  String get onboardingImage2 => "$_imagesAssetsPaths/onboarding_image2.png";
  String get onboardingImage3 => "$_imagesAssetsPaths/onboarding_image3.png";
  String get logo => "$_imagesAssetsPaths/logo.png";



  /// added by zihad
  String get watch => "$_imagesAssetsPaths/watch.png";

  String get graph => "$_imagesAssetsPaths/graph.png";


  /// Profile Image
  String get profileImage => "$_imagesAssetsPaths/profile-image.png";
  String get profileCover => "$_imagesAssetsPaths/profile-cover.png";



}

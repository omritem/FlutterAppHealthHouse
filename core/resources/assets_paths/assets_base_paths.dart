class AssetsBasePaths {

  AssetsBasePaths._internal();

  static final AssetsBasePaths _instance = AssetsBasePaths._internal();

  static  AssetsBasePaths get instance => _instance;

  static const String _basePaths = "assets";

  static String get basePaths => _basePaths;
}
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/helper/app_responsive/screen_size.dart';
import '../../../../core/resources/assets_paths/svg_assets_paths.dart';
import '../../../../core/wrappers/figtree_text.dart';
import '../../../../core/wrappers/svg_viewer.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTapActionText,
    this.isSocialLogin = true,
  });

  final String promptText;
  final String actionText;
  final VoidCallback onTapActionText;
  final bool isSocialLogin;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPromptAndPromptAction(sw),
          if (isSocialLogin)
            Column(
              children: [
                Gap(sw / 24),
                _buildOrText(sw),
                Gap(sw / 24),
                _buildGoogleLogin(sw),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPromptAndPromptAction(double sw) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: sw / 30,
          color: AppColors.textPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(text: "$promptText "),
          TextSpan(
            style: TextStyle(color: AppColors.appThemeColor),
            text: actionText,
            recognizer: TapGestureRecognizer()..onTap = onTapActionText,
          ),
        ],
      ),
    );
  }

  Widget _buildOrText(double sw) {
    return Container(
      height: sw / 10,
      width: sw / 8,
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(sw / 40),
      ),
      alignment: Alignment.center,
      child: FigtreeText(
        text: "OR",
        color: AppColors.appThemeColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildGoogleLogin(double sw) {
    return Container(
      height: sw / 7,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sw / 30),
        border: Border.all(width: 2, color: AppColors.whiteColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgViewer(
            assetName: SvgPath.instance.google,
            height: sw / 16,
            width: sw / 16,
          ),
          Gap(sw / 30),
          FigtreeText(
            text: "Continue with google",
            fontSize: sw / 24,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}

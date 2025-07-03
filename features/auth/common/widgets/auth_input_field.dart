import 'package:flutter/material.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/helper/app_responsive/screen_size.dart';
import '../../../../core/helpers/form_validations.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/wrappers/figtree_text.dart';

class AuthInputField extends StatelessWidget {
  const AuthInputField({
    super.key,
    required this.headerTitle,
    required this.hintText,
    required this.textEditingController,
    this.passwordIcon,
    this.obscureText, this.isReadOnly
  });
  final bool? isReadOnly;
  final String headerTitle;
  final String hintText;
  final TextEditingController textEditingController;
  final IconData? passwordIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final sw = ScreenSize.sw!.value;
    return Padding(
      padding:  EdgeInsets.only(bottom: sw / 10),
      child: Container(
        height: 70,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(sw / 32),
        ),
        child: InputField(
          isReadOnly: isReadOnly ?? false,
          inputTEController: textEditingController,
          hintText: hintText,
          fillColor: AppColors.secondaryAppThemColor,
          hintTextColor: AppColors.whiteColor,
          hintTextFontWeight: FontWeight.w500,
          textColor: AppColors.whiteColor,
          fontWeight: FontWeight.w500,
          borderRadius: 16,
          suffixIcon: passwordIcon,
          formValidator: _getValidator(headerTitle),

        ),
      ),
    );
  }
  FormFieldValidator<String>? _getValidator(String label) {
    switch (label.toLowerCase()) {
      case 'full name':
        return FormValidations.validateName;
      case 'email address':
        return FormValidations.validateEmail;
      case 'password':
        return FormValidations.validatePassword;
      default:
        return null;
    }
  }

}




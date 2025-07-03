import '../resources/constants/validations_constants.dart';

class FormValidations {
  FormValidations._internal();

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty || !ValidationConstants.emailRegExp.hasMatch(email)) {
      return "Invalid email format.";
    }
    return null;
  }

  static String? validateMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty) {
      return "Please enter your phone number.";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter your password.";
    } else if (password.length < 8) {
      return "Password must be at least 8 characters.";
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}$').hasMatch(password)) {
      return "Password must include upper, lower, and a special character.";
    }
    return null;
  }


  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return "Please enter your name.";
    }
    return null;
  }
}
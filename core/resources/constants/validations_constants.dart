class ValidationConstants{
  ValidationConstants._internal();
  static RegExp emailRegExp =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}
// class AppValidator {
//   AppValidator._();
//
//   static String? validateName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Name is required.';
//     }
//     final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
//     if (!nameRegExp.hasMatch(value)) {
//       return 'Name should contain only alphabets.';
//     }
//     return null;
//   }
//
//   // ... (existing validateEmail and validatePassword remain)
//
//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required.';
//     }
//     if (value.length < 8) {
//       return 'Password must be at least 8 characters long.';
//     }
//     if (!value.contains(RegExp(r'[A-Z]'))) {
//       return 'Password must contain at least one uppercase letter.';
//     }
//     if (!value.contains(RegExp(r'[0-9]'))) {
//       return 'Password must contain at least one number.';
//     }
//     if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
//       return 'Password must contain at least one special character.';
//     }
//     return null;
//   }
//
//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required.';
//     }
//     final emailRegExp = RegExp(
//       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//     );
//     if (!emailRegExp.hasMatch(value)) {
//       return 'Please enter a valid email address.';
//     }
//     return null;
//   }
// }
extension StringExtension on String {
  // Regular expression for validating a phone number
  bool isPhoneNumber() {
    final phoneRegex = RegExp(r'^\+?\d+$');
    return phoneRegex.hasMatch(this);
  }
}

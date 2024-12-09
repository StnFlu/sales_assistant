class Validators {
  /// Validates an email address.
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required.';
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  /// Validates a non-empty field.
  static String? validateNonEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  /// Validates that a string matches a given pattern.
  static String? validatePattern(
      String? value, String fieldName, String pattern) {
    if (value == null || !RegExp(pattern).hasMatch(value)) {
      return '$fieldName is invalid.';
    }
    return null;
  }

  /// Validates a phone number.
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required.';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(phoneNumber)) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }
}

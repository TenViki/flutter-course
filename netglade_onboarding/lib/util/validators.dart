String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a password";
  }

  if (value.length <= 4) {
    return "Password must be at least 5 characters";
  }

  // must contain at least one number
  final numberRegex = RegExp(r'[0-9]');
  if (!numberRegex.hasMatch(value)) {
    return "Password must contain at least one number";
  }

  // must contain at least one uppercase letter
  final uppercaseRegex = RegExp(r'[A-Z]');
  if (!uppercaseRegex.hasMatch(value)) {
    return "Password must contain at least one uppercase letter";
  }

  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter an email";
  }

  // email regex
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return "Please enter a valid email";
  }

  return null;
}

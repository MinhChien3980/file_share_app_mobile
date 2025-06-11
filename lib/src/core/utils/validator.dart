part of '../core.dart';

class Validator {
  Validator._();

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Invalid name format';
    }
    return null;
  }

  static String? validateUsername(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < minLength) {
      return 'Username must be at least $minLength characters long';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Invalid username format';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number format';
    }
    return null;
  }

  static String? validatePassword(String? value, {int minLength = 4}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    final urlRegex = RegExp(r'^(https?:\/\/)?([a-zA-Z0-9.-]+)(:[0-9]{1,5})?(\/[^\s]*)?$');
    if (!urlRegex.hasMatch(value)) {
      return 'Invalid URL format';
    }
    return null;
  }

  static String? validateForDate(
    DateTime? value, {
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    if (value == null) {
      return 'Date is required';
    }
    if (minDate != null && value.isBefore(minDate)) {
      return 'Date must be after ${minDate.toLocal()}';
    }
    if (maxDate != null && value.isAfter(maxDate)) {
      return 'Date must be before ${maxDate.toLocal()}';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number is required';
    }
    final numberRegex = RegExp(r'^[0-9]+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Invalid number format';
    }
    return null;
  }

  static String? validateLength(String? value, int minLength, {int maxLength = 100}) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < minLength) {
      return 'Minimum length is $minLength characters';
    }
    if (value.length > maxLength) {
      return 'Maximum length is $maxLength characters';
    }
    return null;
  }

  static String? validateDateRange(
    DateTime? value, {
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    if (value == null) {
      return 'Date is required';
    }
    if (minDate != null && value.isBefore(minDate)) {
      return 'Date must be after ${minDate.toLocal()}';
    }
    if (maxDate != null && value.isAfter(maxDate)) {
      return 'Date must be before ${maxDate.toLocal()}';
    }
    return null;
  }
}

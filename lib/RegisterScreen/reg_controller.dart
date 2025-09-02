// lib/RegisterScreen/reg_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isTermsAccepted = false.obs;

  void toggleTermsAccepted(bool? value) {
    if (value != null) {
      isTermsAccepted.value = value;
    }
  }

  bool validateForm() {
    // Validate full name
    if (fullNameController.text.trim().isEmpty) {
      showErrorSnackbar('Validation Error', 'Please enter your full name');
      return false;
    }

    // Validate email
    if (emailController.text.trim().isEmpty) {
      showErrorSnackbar('Validation Error', 'Please enter your email address');
      return false;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.text.trim())) {
      showErrorSnackbar('Validation Error', 'Please enter a valid email address');
      return false;
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      showErrorSnackbar('Validation Error', 'Please create a password');
      return false;
    }

    // Validate password length
    if (passwordController.text.length < 6) {
      showErrorSnackbar('Validation Error', 'Password must be at least 6 characters long');
      return false;
    }

    // Validate confirm password
    if (confirmPasswordController.text.isEmpty) {
      showErrorSnackbar('Validation Error', 'Please confirm your password');
      return false;
    }

    // Validate password match
    if (passwordController.text != confirmPasswordController.text) {
      showErrorSnackbar('Validation Error', 'Passwords do not match');
      return false;
    }

    return true;
  }

  void showErrorSnackbar(String title, String message) {
    final isDarkMode = Get.isDarkMode;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDarkMode ? Colors.red[800] : Colors.red[100],
      colorText: isDarkMode ? Colors.white : Colors.red[900],
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
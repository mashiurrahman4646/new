// lib/verification/verification_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  // OTP controllers for each input field
  List<TextEditingController> otpControllers = List.generate(
    6,
        (index) => TextEditingController(),
  );

  // Observable for verify button state
  var isVerifyEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add listeners to all OTP controllers
    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(() {
        checkVerifyButtonState();
      });
    }
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      // Move to next field if current field is filled and not the last field
      if (index < 5) {
        FocusScope.of(Get.context!).nextFocus();
      }
    } else {
      // Move to previous field if current field is empty and not the first field
      if (index > 0) {
        FocusScope.of(Get.context!).previousFocus();
      }
    }
    checkVerifyButtonState();
  }

  void checkVerifyButtonState() {
    // Check if all OTP fields are filled
    bool allFilled = otpControllers.every((controller) => controller.text.isNotEmpty);
    isVerifyEnabled.value = allFilled;
  }

  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  void verifyOtp() {
    String otpCode = getOtpCode();

    if (otpCode.length == 6) {
      // Show loading
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: const Color(0xFF4A90E2),
          ),
        ),
        barrierDismissible: false,
      );

      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        Get.back(); // Close loading dialog

        // For demo purposes, accept any 6-digit code
        Get.snackbar(
          'Success',
          'Email verified successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[900],
          margin: const EdgeInsets.all(12),
        );

        // Navigate to face verification after successful email verification
        Get.offNamed('/faceVerification');
      });
    } else {
      Get.snackbar(
        'Invalid Code',
        'Please enter a valid 6-digit verification code.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(12),
      );
    }
  }

  void resendCode() {
    // Clear current OTP
    for (var controller in otpControllers) {
      controller.clear();
    }

    // Show success message
    Get.snackbar(
      'Code Sent',
      'A new verification code has been sent to your email.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue[100],
      colorText: Colors.blue[900],
      margin: const EdgeInsets.all(12),
    );

    // Reset verify button state
    checkVerifyButtonState();
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
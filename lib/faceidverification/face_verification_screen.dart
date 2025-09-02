// lib/faceidverification/face_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Settings/appearance/ThemeController.dart';
import '../colors/app_colors.dart';
import '../text_styles.dart';


class FaceVerificationScreen extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive ? AppColors.darkBackground : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow-left.png',
            width: 24,
            height: 24,
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'set_your_face_id'.tr,
          style: AppTextStyles.heading2.copyWith(
            color: themeController.isDarkModeActive ? Colors.white : const Color(0xFF000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Updated Progress Indicator for 3 steps
            _buildProgressIndicator(context),
            SizedBox(height: 32),
            Text(
              'face_id_description'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: themeController.isDarkModeActive ? Colors.white70 : Colors.black87,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 32),
            // Clickable Face ID Image
            GestureDetector(
              onTap: () {
                _handleFaceVerification();
              },
              child: Image.asset(
                'assets/images/face-id.png',
                width: 150,
                height: 150,
                color: themeController.isDarkModeActive ? AppColors.primary300 : null,
              ),
            ),
            SizedBox(height: 32),
            // Setup Face ID Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _handleFaceVerification();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'setup_face_id'.tr,
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Cancel Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/mainHome');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeController.isDarkModeActive ? AppColors.darkCardBackground : Colors.white,
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'skip_for_now'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final themeController = Get.find<ThemeController>();

    return Column(
      children: [
        SizedBox(
          height: 32,
          child: Stack(
            children: [
              // Background line
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: themeController.isDarkModeActive ? Colors.grey[800] : Colors.grey[300],
                ),
              ),
              // Progress line (completed steps)
              Positioned(
                top: 15,
                left: 0,
                child: Container(
                  width: screenWidth * 0.75,
                  height: 2,
                  color: AppColors.primary500,
                ),
              ),
              // Step circles
              Positioned(
                left: (screenWidth * 0.15) - 12,
                top: 4,
                child: _buildStepCircle(1, true),
              ),
              Positioned(
                left: (screenWidth * 0.5) - 12,
                top: 4,
                child: _buildStepCircle(2, true),
              ),
              Positioned(
                left: (screenWidth * 0.85) - 12,
                top: 4,
                child: _buildStepCircle(3, true),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth * 0.25,
              child: Text(
                'registration'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.25,
              child: Text(
                'verification'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.25,
              child: Text(
                'face_id'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.primary500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber, bool isActive) {
    final themeController = Get.find<ThemeController>();

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary500 :
        (themeController.isDarkModeActive ? Colors.grey[700] : Colors.grey[400]),
        shape: BoxShape.circle,
        border: Border.all(
            color: AppColors.primary500,
            width: 2
        ),
      ),
      child: Center(
        child: Text(
          stepNumber.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _handleFaceVerification() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: AppColors.primary500,
        ),
      ),
      barrierDismissible: false,
    );

    Future.delayed(Duration(seconds: 2), () {
      Get.back();
      Get.snackbar(
        'success'.tr,
        'face_id_setup_success'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.find<ThemeController>().isDarkModeActive
            ? Colors.green[900]
            : Colors.green[100],
        colorText: Get.find<ThemeController>().isDarkModeActive
            ? Colors.white
            : Colors.green[900],
        margin: const EdgeInsets.all(12),
      );

      Future.delayed(Duration(seconds: 1), () {
        Get.offAllNamed('/signupVerification');
      });
    });
  }
}
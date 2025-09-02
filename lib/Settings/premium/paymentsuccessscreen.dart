import 'package:flutter/material.dart';
import 'package:get/get.dart';
 // Import your ThemeController

import '../../routes/app_routes.dart';
import '../appearance/ThemeController.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/done.png',
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,

              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                "payment_success_title".tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "payment_success_subtitle".tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: themeController.isDarkModeActive
                      ? Colors.grey[400]
                      : const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.06),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.settings);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'continue_button'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
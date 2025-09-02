import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appearance/ThemeController.dart';
 // Import your ThemeController

class SetupFaceIDScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            size: screenWidth * 0.05,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'setup_faceid'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.06),

            // Title Text
            Text(
              'setup_faceid_desc'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.042,
                color: themeController.isDarkModeActive ? Colors.grey[400] : const Color(0xFF374151),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            SizedBox(height: screenHeight * 0.08),

            // Face ID Image (clickable)
            GestureDetector(
              onTap: () {
                // Navigate to face authentication screen
                Get.toNamed('/faceAuthentication');
              },
              child: Container(
                width: screenWidth * 0.55,
                height: screenWidth * 0.55,
                child: Image.asset(
                  'assets/images/face-id (2).png',
                  fit: BoxFit.contain,
                  color: themeController.isDarkModeActive ? Colors.white : null,
                ),
              ),
            ),

            const Spacer(),

            // Use PIN Instead Button
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Get.toNamed('/setPin'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                ),
                child: Text(
                  'use_pin_instead'.tr,
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    color: themeController.isDarkModeActive ? Colors.grey[400] : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Cancel Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeController.isDarkModeActive
                      ? const Color(0xFF1E1E1E)
                      : const Color(0xFFF8F9FA),
                  foregroundColor: const Color(0xFFDC2626),
                  elevation: 0,
                  side: const BorderSide(
                    color: Color(0xFFDC2626),
                    width: 1.5,
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                ),
                child: Text(
                  'cancel'.tr,
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    ));
  }
}
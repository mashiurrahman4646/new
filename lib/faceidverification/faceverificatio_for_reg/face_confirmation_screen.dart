import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Settings/appearance/ThemeController.dart';
import '../../routes/app_routes.dart';


class FaceConfirmationScreen extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkMode.value
          ? const Color(0xFF121212)
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Fingerprint-confarm.png',
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 40),

            // Title
            Text(
              'faceid_added'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: themeController.isDarkMode.value
                    ? Colors.white.withOpacity(0.9)
                    : const Color(0xFF535353),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'faceid_protected'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: themeController.isDarkMode.value
                    ? Colors.white.withOpacity(0.7)
                    : const Color(0xFF6A6A6A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 48),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.mainHome);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3787F2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'continue'.tr,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
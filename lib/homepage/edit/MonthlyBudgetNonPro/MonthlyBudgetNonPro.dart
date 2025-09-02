import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../../Settings/appearance/ThemeController.dart';
import '../../../make it pro/AdvertisementPage/MonthlyBudgetProadd.dart';


class MonthlyBudgetNonPro extends StatelessWidget {
  const MonthlyBudgetNonPro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkMode.value
          ? const Color(0xFF121212)
          : Colors.white,
      appBar: AppBar(
        title: Text(
          "monthly_budget".tr,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: themeController.isDarkMode.value
                ? Colors.white
                : Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: themeController.isDarkMode.value
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: themeController.isDarkMode.value
                  ? Colors.white
                  : Colors.black,
              size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Blurred background content
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Budget Display
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: themeController.isDarkMode.value
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: themeController.isDarkMode.value
                            ? Colors.grey.shade800
                            : const Color(0xFFF0F0F0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\$2,500',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: themeController.isDarkMode.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Budget distribution list
                  Expanded(
                    child: ListView(
                      children: [
                        _buildBudgetItem(themeController, 'Food', '\$500',
                            '20%', Icons.fastfood),
                        _buildBudgetItem(themeController, 'Transport',
                            '\$300', '12%', Icons.directions_car),
                        _buildBudgetItem(themeController, 'Housing',
                            '\$1,000', '40%', Icons.home),
                        _buildBudgetItem(themeController, 'Entertainment',
                            '\$200', '8%', Icons.movie),
                        _buildBudgetItem(themeController, 'Utilities',
                            '\$150', '6%', Icons.bolt),
                        _buildBudgetItem(themeController, 'Savings',
                            '\$350', '14%', Icons.savings),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Upgrade to Pro overlay
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: themeController.isDarkMode.value
                    ? const Color(0xFF1E1E1E)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 48,
                    color: themeController.isDarkMode.value
                        ? Colors.blue.shade200
                        : const Color(0xFF2196F3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'upgrade_title'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'upgrade_subtitle'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: themeController.isDarkMode.value
                          ? Colors.grey.shade400
                          : const Color(0xFF6A6A6A),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const MonthlyBudgetPro());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'upgrade_now'.tr,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'maybe_later'.tr,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: themeController.isDarkMode.value
                            ? Colors.grey.shade400
                            : const Color(0xFF6A6A6A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildBudgetItem(ThemeController themeController, String category,
      String amount, String percentage, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeController.isDarkMode.value
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: themeController.isDarkMode.value
              ? Colors.grey.shade800
              : const Color(0xFFF0F0F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: themeController.isDarkMode.value
                  ? const Color(0xFF2C2C2C)
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon,
                color: themeController.isDarkMode.value
                    ? Colors.blue.shade200
                    : Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              category,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Text(
                percentage,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: themeController.isDarkMode.value
                      ? Colors.grey.shade400
                      : const Color(0xFF6A6A6A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

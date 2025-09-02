import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/Settings/premium/paymenttypetui.dart';


import '../appearance/ThemeController.dart'; // Import your ThemeController

class PremiumPlansScreen extends StatelessWidget {
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
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'premium_plans'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03),

              // Header Section
              Text(
                'premium_header'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'premium_subheader'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: themeController.isDarkModeActive
                      ? Colors.grey[400]
                      : const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Monthly Plan
              _buildPlanCard(
                title: 'monthly_plan'.tr,
                price: 'monthly_price'.tr,
                trialText: 'free_trial'.tr,
                isRecommended: false,
                isSelected: false,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Yearly Plan
              _buildPlanCard(
                title: 'yearly_plan'.tr,
                price: 'yearly_price'.tr,
                trialText: 'free_trial'.tr,
                isRecommended: true,
                isSelected: true,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                saveText: 'save_percentage'.tr,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.04),

              // What's Included Section
              Text(
                'whats_included'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              _buildFeatureItem(
                'feature_1'.tr,
                screenWidth,
                screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              _buildFeatureItem(
                'feature_2'.tr,
                screenWidth,
                screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              _buildFeatureItem(
                'feature_3'.tr,
                screenWidth,
                screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.06),

              // Upgrade Button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => PaymentScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'upgrade_now'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String trialText,
    required bool isRecommended,
    required bool isSelected,
    required double screenWidth,
    required double screenHeight,
    required bool isDarkMode,
    String? saveText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF2196F3)
              : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: const Color(0xFF2196F3).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF2196F3)
                          : (isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                    child: Container(
                      width: screenWidth * 0.025,
                      height: screenWidth * 0.025,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF2196F3),
                      ),
                    ),
                  )
                      : null,
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  trialText,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: const Color(0xFF2196F3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (saveText != null || isRecommended) ...[
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.08),
                  if (saveText != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Text(
                        saveText,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  if (isRecommended) ...[
                    SizedBox(width: screenWidth * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Text(
                        'recommended'.tr,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: const Color(0xFF2196F3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, double screenWidth, double screenHeight, {required bool isDarkMode}) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.06,
            height: screenWidth * 0.06,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2196F3),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: screenWidth * 0.035,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
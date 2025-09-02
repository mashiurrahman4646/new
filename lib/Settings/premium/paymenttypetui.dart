import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/Settings/premium/paymentsuccessscreen.dart';

import '../appearance/ThemeController.dart';
 // Import your ThemeController

class PaymentScreen extends StatelessWidget {
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
          'complete_payment'.tr,
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
                "payment_header".tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Payment Methods Section
              Text(
                'choose_payment_method'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Card Payment Option
              _buildPaymentMethodCard(
                context: context,
                title: 'card_payment'.tr,
                description: 'card_payment_desc'.tr,
                iconPath: 'assets/icons/CardPayment.png',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isSelected: true,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.015),

              // Mobile Wallet Option
              _buildPaymentMethodCard(
                context: context,
                title: 'mobile_wallet'.tr,
                description: 'mobile_wallet_desc'.tr,
                iconPath: 'assets/icons/MobileWallet.png',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isSelected: false,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.015),

              // Bank Transfer Option
              _buildPaymentMethodCard(
                context: context,
                title: 'bank_transfer'.tr,
                description: 'bank_transfer_desc'.tr,
                iconPath: 'assets/icons/BankTransfer.png',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isSelected: false,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.04),

              // Card Details Form
              Text(
                'card_number'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              TextField(
                decoration: InputDecoration(
                  hintText: 'card_number_hint'.tr,
                  hintStyle: TextStyle(
                    color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[600],
                  ),
                  filled: themeController.isDarkModeActive,
                  fillColor: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(
                      color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(
                      color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                style: TextStyle(
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: screenHeight * 0.02),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'expiry_date'.tr,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'expiry_date_hint'.tr,
                            hintStyle: TextStyle(
                              color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[600],
                            ),
                            filled: themeController.isDarkModeActive,
                            fillColor: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(
                                color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(
                                color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.02,
                            ),
                          ),
                          style: TextStyle(
                            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'cvv'.tr,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'cvv_hint'.tr,
                            hintStyle: TextStyle(
                              color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[600],
                            ),
                            filled: themeController.isDarkModeActive,
                            fillColor: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(
                                color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: BorderSide(
                                color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.02,
                            ),
                          ),
                          style: TextStyle(
                            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              Text(
                'name_on_card'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              TextField(
                decoration: InputDecoration(
                  hintText: 'name_on_card_hint'.tr,
                  hintStyle: TextStyle(
                    color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[600],
                  ),
                  filled: themeController.isDarkModeActive,
                  fillColor: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(
                      color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(
                      color: themeController.isDarkModeActive ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                style: TextStyle(
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.06),

              // Pay Now Button - Updated to navigate to success screen
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate form first if needed
                    // Then navigate to success screen
                    Get.to(() => PaymentSuccessScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'pay_now'.tr,
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

  Widget _buildPaymentMethodCard({
    required BuildContext context,
    required String title,
    required String description,
    required String iconPath,
    required double screenWidth,
    required double screenHeight,
    required bool isSelected,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle payment method selection
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2196F3)
                : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
                color: isDarkMode ? Colors.white : null,
              ),
              SizedBox(width: screenWidth * 0.04),
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
                      description,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF2196F3),
                  size: screenWidth * 0.06,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
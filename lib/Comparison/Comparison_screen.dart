import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Settings/appearance/ThemeController.dart';
import '../homepage/main_home_page_controller.dart';
import '../reuseablenav/reuseablenavui.dart';
 // Import the custom navbar

class ComparisonPageScreen extends StatelessWidget {
  final bool isFromExpense;

  const ComparisonPageScreen({super.key, required this.isFromExpense});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final homeCtrl = Get.find<HomeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeCtrl.selectedNavIndex.value != 2) {
        homeCtrl.selectedNavIndex.value = 2;
      }
    });

    final bool isDarkMode = themeController.isDarkModeActive;
    final Color backgroundColor = isDarkMode ? Color(0xFF121212) : Colors.white;
    final Color cardColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'compare_save'.tr,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),

            // Find Better Deals Section
            Text(
              'find_better_deals'.tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'find_better_deals_desc'.tr,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[400] : Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Product Name Field
            Text(
              'product_name'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                border: Border.all(color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintStyle: TextStyle(color: isDarkMode ? Colors.grey[500] : Colors.grey),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Price Paid Field
            Text(
              'price_paid'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                border: Border.all(color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: 'enter_amount'.tr,
                  hintStyle: TextStyle(color: isDarkMode ? Colors.grey[500] : Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Product Description Field
            Text(
              'product_description'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                border: Border.all(color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                maxLines: 4,
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: 'description_hint'.tr,
                  hintStyle: TextStyle(color: isDarkMode ? Colors.grey[500] : Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),

            // Better Deals Found Section
            Text(
              'better_deals_found'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Amazon Deal Card
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Amazon Logo - Fixed with better error handling
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800]! : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: _buildAmazonLogo(isDarkMode),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amazon',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Nike Air Max 270 - Men\'s Running',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey[300] : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Best Deal',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue[300],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: Colors.blue[300],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Save Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Save 23%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                      border: Border.all(color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle Copy Link action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: _buildCopyLinkIcon(isDarkMode),
                      label: Text(
                        'copy_link'.tr,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                      border: Border.all(color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to comparison graph screen
                        Get.toNamed('/comparisonGraph');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: _buildCompareIcon(isDarkMode),
                      label: Text(
                        'compare'.tr,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),

            // Confirm Purchase Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle Confirm Purchase action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  'confirm_purchase'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
      // Use the consistent navigation bar
      bottomNavigationBar: CustomBottomNavBar(
        isDarkMode: isDarkMode,
      ),
    );
  }

  // Helper method to build Amazon logo based on theme
  Widget _buildAmazonLogo(bool isDarkMode) {
    return Image.asset(
      isDarkMode
          ? 'assets/icons/AmazonLogo (1).png'
          : 'assets/icons/AmazonLogo.png',
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    );
  }

  // Helper method to build copy link icon
  Widget _buildCopyLinkIcon(bool isDarkMode) {
    try {
      return Image.asset(
        'assets/icons/copy_link.png',
        width: 20,
        height: 20,
        color: isDarkMode ? Colors.white : null,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.link,
            size: 20,
            color: isDarkMode ? Colors.white : Colors.black54,
          );
        },
      );
    } catch (e) {
      return Icon(
        Icons.link,
        size: 20,
        color: isDarkMode ? Colors.white : Colors.black54,
      );
    }
  }

  // Helper method to build compare icon
  Widget _buildCompareIcon(bool isDarkMode) {
    try {
      return Image.asset(
        'assets/icons/compare.png',
        width: 20,
        height: 20,
        color: isDarkMode ? Colors.white : null,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/icons/Group 4.png',
            width: 20,
            height: 20,
            color: isDarkMode ? Colors.white : null,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.compare,
                size: 20,
                color: isDarkMode ? Colors.white : Colors.black54,
              );
            },
          );
        },
      );
    } catch (e) {
      return Icon(
        Icons.compare,
        size: 20,
        color: isDarkMode ? Colors.white : Colors.black54,
      );
    }
  }
}
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import '../../Settings/appearance/ThemeController.dart';
import '../../routes/app_routes.dart';

class NonProSavingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final bool isDarkMode = themeController.isDarkModeActive;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'totalSavings'.tr,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combined Header and Chart Section with Upgrade Overlay
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  // Content to be blurred (Header + Chart)
                  Column(
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'totalSaving'.tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$24,050',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: isDarkMode ? const Color(0xFF333333) : Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(20),
                                color: isDarkMode ? const Color(0xFF333333) : Colors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'monthly'.tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.keyboard_arrow_down,
                                      size: 16,
                                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Chart Section
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.grey[50],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          border: Border.all(
                              color: isDarkMode ? const Color(0xFF333333) : Colors.grey[200]!,
                              width: 1
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: _buildGraph(isDarkMode),
                        ),
                      ),
                    ],
                  ),

                  // Blur overlay with upgrade content - covering both header and chart
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: (isDarkMode ? Colors.black : Colors.white).withOpacity(0.85),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'upgradeToProToView'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode ? Colors.white : Colors.black87,
                                  ),
                                ),
                                Text(
                                  'graphsAndReports'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode ? Colors.white : Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.totalSavingAdvertisement);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF4A90E2),
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.workspace_premium,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'upgradeNow'.tr,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Recent Transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'recentTransaction'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Transaction List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDarkMode ? const Color(0xFF333333) : Colors.grey[200]!,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Amazon Logo
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: isDarkMode ? const Color(0xFF333333) : Colors.grey[200]!,
                              width: 1
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: isDarkMode
                              ? Image.asset(
                            'assets/icons/AmazonLogo (1).png', // White Amazon logo for dark mode
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'a',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                              : Image.asset(
                            'assets/icons/AmazonLogo.png', // Regular Amazon logo for light mode
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'a',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      // Transaction Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amazon',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$129.99',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Nike Air Max 270 - Men\'s Running',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '\$169.99',
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                    color: isDarkMode ? Colors.grey[500] : Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGraph(bool isDarkMode) {
    return Container(
      child: Column(
        children: [
          // Chart title/legend area
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLegendItem('original'.tr, Color(0xFFE5E5E5), isDarkMode),
                SizedBox(width: 16),
                _buildLegendItem('usingApp'.tr, Color(0xFF4A90E2), isDarkMode),
                SizedBox(width: 16),
                _buildLegendItem('savings'.tr, Color(0xFF88C999), isDarkMode),
              ],
            ),
          ),
          // Y-axis labels and bars
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Container(
                  width: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('100', style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('80', style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('60', style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('40', style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('20', style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('0', style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                // Chart bars
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBarGroup('laptop'.tr, 75, 60, 25, isDarkMode),
                      _buildBarGroup('food'.tr, 95, 70, 45, isDarkMode),
                      _buildBarGroup('gift'.tr, 50, 30, 20, isDarkMode),
                      _buildBarGroup('shopping'.tr, 70, 45, 30, isDarkMode),
                      _buildBarGroup('electronics'.tr, 80, 55, 35, isDarkMode),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isDarkMode) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildBarGroup(String label, double original, double usingApp, double savings, bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 8,
                height: original * 1.2,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E5E5), // Lighter gray
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 3),
              Container(
                width: 8,
                height: usingApp * 1.2,
                decoration: BoxDecoration(
                  color: Color(0xFF4A90E2), // Blue
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 3),
              Container(
                width: 8,
                height: savings * 1.2,
                decoration: BoxDecoration(
                  color: Color(0xFF88C999), // Green
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Settings/appearance/ThemeController.dart';

class ProSavingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final bool isDarkMode = themeController.isDarkModeActive;

    return WillPopScope(
      onWillPop: () async {
        // Navigate to MainHomeScreen when back button is pressed
        Get.offAllNamed('/mainHome'); // or use your route name
        return false; // Prevent default back navigation
      },
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        appBar: AppBar(
          backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 20),
            onPressed: () {
              // Navigate to MainHomeScreen when back arrow is pressed
              Get.offAllNamed('/comparison'); // or use your route name
            },
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
              // Header Section
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                        border: Border.all(
                          color: isDarkMode ? const Color(0xFF333333) : Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
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
                height: 200,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: _buildGraph(isDarkMode),
              ),

              // Legend
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildLegend(isDarkMode),
              ),

              // Summary Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('withoutAppsTotal'.tr, '\$3,450.00', isDarkMode ? Colors.white : Colors.black, isDarkMode),
                    SizedBox(height: 8),
                    _buildSummaryRow('withAppsTotal'.tr, '\$3,450.00', isDarkMode ? Colors.white : Colors.black, isDarkMode),
                    SizedBox(height: 8),
                    _buildSummaryRow('totalSavingAmount'.tr, '\$3,450.00', Color(0xFF88C999), isDarkMode),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Recent Transactions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'recentTransaction'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        // Amazon Logo
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isDarkMode ? const Color(0xFF333333) : Colors.grey[200]!,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: isDarkMode
                                ? Image.asset(
                              'assets/icons/AmazonLogo (1).png', // White Amazon logo for dark mode
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange[50],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.shopping_bag,
                                      color: Colors.orange[700],
                                      size: 16,
                                    ),
                                  ),
                                );
                              },
                            )
                                : Image.asset(
                              'assets/icons/AmazonLogo.png', // Regular Amazon logo for light mode
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange[50],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.shopping_bag,
                                      color: Colors.orange[700],
                                      size: 16,
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
                                      fontSize: 14,
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
                                    ),
                                  ),
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
      ),
    );
  }

  Widget _buildGraph(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Y-axis labels and bars
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Container(
                  width: 25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('100', style: TextStyle(fontSize: 11, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('80', style: TextStyle(fontSize: 11, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('60', style: TextStyle(fontSize: 11, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('40', style: TextStyle(fontSize: 11, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('20', style: TextStyle(fontSize: 11, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                      Text('0', style: TextStyle(fontSize: 11, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
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

  Widget _buildBarGroup(String label, double original, double usingApp, double savings, bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 6,
                height: original * 1.1,
                decoration: BoxDecoration(
                  color: Color(0xFFA3A3A3), // Gray color from Figma
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              SizedBox(width: 2),
              Container(
                width: 6,
                height: usingApp * 1.1,
                decoration: BoxDecoration(
                  color: Color(0xFF4A90E2), // Blue color from Figma
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              SizedBox(width: 2),
              Container(
                width: 6,
                height: savings * 1.1,
                decoration: BoxDecoration(
                  color: Color(0xFF88C999), // Green color from Figma
                  borderRadius: BorderRadius.circular(1),
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
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Color(0xFFA3A3A3), 'originalPrice'.tr, isDarkMode),
        SizedBox(width: 12),
        _legendItem(Color(0xFF4A90E2), 'usingApp'.tr, isDarkMode),
        SizedBox(width: 12),
        _legendItem(Color(0xFF88C999), 'saving'.tr, isDarkMode),
      ],
    );
  }

  Widget _legendItem(Color color, String label, bool isDarkMode) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
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

  Widget _buildSummaryRow(String label, String value, Color valueColor, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
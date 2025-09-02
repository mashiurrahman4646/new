import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appearance/ThemeController.dart';
 // Import your ThemeController

class CurrencyExchangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Controller to manage selected currency
    final _controller = Get.put(CurrencyController());

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive
          ? const Color(0xFF121212)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive
            ? const Color(0xFF1E1E1E)
            : Colors.white,
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
          'currency_exchange'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: screenWidth * 0.045,
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
            SizedBox(height: screenHeight * 0.03),
            Text(
              'choose_currency_desc'.tr,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Currencies List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _controller.currencies.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: themeController.isDarkModeActive
                            ? const Color(0xFF333333)
                            : const Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      _controller.currencies[index].name.tr,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      _controller.currencies[index].code,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    trailing: Radio(
                      value: index,
                      groupValue: _controller.selectedCurrencyIndex.value,
                      onChanged: (int? newValue) {
                        _controller.selectedCurrencyIndex.value = newValue!;
                      },
                      activeColor: const Color(0xFF2196F3),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: screenHeight * 0.05),

            // Apply Button
            Container(
              width: double.infinity,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  _controller.applyCurrencyChange();
                  Get.snackbar(
                    'success'.tr,
                    'currency_updated'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.blue,
                    colorText: Colors.white,
                  );
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                ),
                child: Text(
                  'apply_changes'.tr,
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
    ));
  }
}

// Controller for managing currency selection and logic
class CurrencyController extends GetxController {
  final List<Currency> currencies = [
    Currency('USD', 'usd_name'.tr),
    Currency('GBP', 'gbp_name'.tr),
    Currency('EUR', 'eur_name'.tr),
    Currency('PLN', 'pln_name'.tr),
    Currency('TRY', 'try_name'.tr),
  ];

  // Selected index
  RxInt selectedCurrencyIndex = 0.obs; // Default to USD

  void applyCurrencyChange() {
    // Here you can save the selected currency to shared preferences or database
    // Example:
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('selected_currency', currencies[selectedCurrencyIndex.value].code);
    print('Selected Currency: ${currencies[selectedCurrencyIndex.value].code}');
  }
}

// Currency model class
class Currency {
  final String code;
  final String name;

  Currency(this.code, this.name);
}
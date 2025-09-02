import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../appearance/ThemeController.dart';
// Import your ThemeController

class ConfirmPinScreen extends StatefulWidget {
  @override
  _ConfirmPinScreenState createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  List<TextEditingController> pinControllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  String pin = '';
  String originalPin = '';

  @override
  void initState() {
    super.initState();
    originalPin = Get.arguments['pin'] ?? '';
  }

  @override
  void dispose() {
    for (var controller in pinControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onPinChanged(int index, String value) {
    if (value.isNotEmpty && value.length == 1) {
      setState(() {
        pinControllers[index].text = value;
      });

      // Move to next field
      if (index < 5) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      // Move to previous field when deleting
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }

    // Update PIN string
    setState(() {
      pin = '';
      for (var controller in pinControllers) {
        pin += controller.text;
      }
    });
  }

  void _clearPin() {
    setState(() {
      for (var controller in pinControllers) {
        controller.clear();
      }
      pin = '';
      FocusScope.of(context).requestFocus(focusNodes[0]);
    });
  }

  void _confirmAction() {
    if (pin.length >= 4) {
      if (pin == originalPin) {
        Get.snackbar(
          'success'.tr,
          'pin_set_success'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade800,
          duration: Duration(seconds: 2),
        );
        // Save the PIN and go back to App Unlock screen
        Get.until((route) => route.settings.name == '/appUnlock');
      } else {
        Get.snackbar(
          'error'.tr,
          'pin_mismatch'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade800,
          duration: Duration(seconds: 2),
        );
        _clearPin();
      }
    } else {
      Get.snackbar(
        'invalid_pin'.tr,
        'pin_min_length'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
          'confirm_pin'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),

            // Title
            Text(
              'confirm_pin'.tr,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w600,
                color: themeController.isDarkModeActive ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Description
            Text(
              'confirm_pin_desc'.tr,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: themeController.isDarkModeActive ? Colors.grey[400] : const Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),

            // PIN Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) => _buildPinField(index, screenWidth, themeController.isDarkModeActive)),
            ),

            Spacer(),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Clear Button
                TextButton(
                  onPressed: _clearPin,
                  child: Text(
                    'clear'.tr,
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.grey[400] : const Color(0xFF6B7280),
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Confirm Button
                TextButton(
                  onPressed: pin.length >= 4 ? _confirmAction : null,
                  child: Text(
                    'confirm'.tr,
                    style: TextStyle(
                      color: pin.length >= 4
                          ? const Color(0xFF2196F3)
                          : (themeController.isDarkModeActive ? Colors.grey[600] : const Color(0xFF9CA3AF)),
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    ));
  }

  Widget _buildPinField(int index, double screenWidth, bool isDarkMode) {
    return Container(
      width: screenWidth * 0.12,
      height: screenWidth * 0.12,
      decoration: BoxDecoration(
        border: Border.all(
          color: pinControllers[index].text.isNotEmpty
              ? const Color(0xFF2196F3)
              : (isDarkMode ? const Color(0xFF444444) : const Color(0xFFE5E7EB)),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      ),
      child: TextField(
        controller: pinControllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          filled: true,
          fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        ),
        cursorColor: const Color(0xFF2196F3),
        onChanged: (value) => _onPinChanged(index, value),
        onTap: () {
          // Clear the field when tapped
          pinControllers[index].clear();
          _onPinChanged(index, '');
        },
      ),
    );
  }
}
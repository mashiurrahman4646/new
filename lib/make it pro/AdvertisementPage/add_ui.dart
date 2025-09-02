import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 // Import your ThemeController

import '../../Settings/appearance/ThemeController.dart';
import '../../add_exp/normaluser/normal_income_and_exp_screen.dart';
import '../../add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';
import '../../routes/app_routes.dart';

class AppColors {
  static const Color text900 = Color(0xFF1E1E1E);
  static const Color text50 = Color(0xFFFAFAFA);
  static const Color primary = Colors.blueAccent;
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color green = Colors.green;
}

class AppStyles {
  static const double defaultRadius = 12.0;
}

class AdvertisementPage extends StatefulWidget {
  final bool isFromExpense;

  const AdvertisementPage({super.key, required this.isFromExpense});

  @override
  State<AdvertisementPage> createState() => _AdvertisementPageState();
}

class _AdvertisementPageState extends State<AdvertisementPage> {
  late final ProExpensesIncomeController proController;
  int _remainingSeconds = 30;
  late Timer _timer;
  bool _isVideoPlaying = false;
  bool _isVideoComplete = false;
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();

    // Use global controller or create if not exists
    proController = Get.isRegistered<ProExpensesIncomeController>()
        ? Get.find<ProExpensesIncomeController>()
        : Get.put(ProExpensesIncomeController());

    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (!mounted) return;
    _isVideoPlaying = true;
    _remainingSeconds = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds == 0) {
        setState(() {
          _isVideoComplete = true;
          _isVideoPlaying = false;
        });
        timer.cancel();
        _unlockProFeatures();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _unlockProFeatures() async {
    if (!mounted) return;
    await proController.unlockProFeatures(widget.isFromExpense);

    // Navigate to the correct pro screen based on where the user came from
    if (widget.isFromExpense) {
      // Came from expense page, go to expense pro
      Get.offNamed(
        AppRoutes.proExpensesIncome,
        arguments: {'defaultTab': 0}, // 0 for expense tab
      );
    } else {
      // Came from income page, go to income pro
      Get.offNamed(
        AppRoutes.proExpensesIncome,
        arguments: {'defaultTab': 1}, // 1 for income tab
      );
    }

    // Show success message
    Get.snackbar(
      'proUnlockedTitle'.tr,
      'proUnlockedMessage'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.green,
      colorText: AppColors.text50,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() => WillPopScope(
      onWillPop: () async {
        // Prevent going back with device back button
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'watchAdTitle'.tr,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: themeController.isDarkModeActive ? Colors.white : AppColors.text900,
            ),
          ),
          // Removed the back button
          automaticallyImplyLeading: false,
          backgroundColor: themeController.isDarkModeActive ? const Color(0xFF1E1E1E) : AppColors.text50,
          elevation: 1,
          iconTheme: IconThemeData(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: themeController.isDarkModeActive ? const Color(0xFF121212) : AppColors.text50,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.1),
                        Text(
                          'watchAdSubtitle'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeActive ? Colors.white : AppColors.text900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.05),
                        GestureDetector(
                          onTap: _isVideoPlaying ? null : _startTimer,
                          child: Container(
                            width: size.width * 0.8,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.grey[300],
                              image: const DecorationImage(
                                image: AssetImage('assets/images/adv.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(
                                  AppStyles.defaultRadius),
                            ),
                            child: Center(
                              child: _isVideoPlaying
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'secondsRemaining'.trParams({'seconds': _remainingSeconds.toString()}),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CircularProgressIndicator(
                                    value: _remainingSeconds / 30,
                                    backgroundColor: themeController.isDarkModeActive ? Colors.grey[700] : Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                  ),
                                ],
                              )
                                  : Icon(
                                Icons.play_circle_filled,
                                size: 50,
                                color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'watchAdDescription'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: themeController.isDarkModeActive ? Colors.grey[400] : AppColors.grey500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          'proFeaturesUnlockMessage'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: themeController.isDarkModeActive ? Colors.grey[400] : AppColors.grey500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.05),
                        // Add a cancel button that goes back to the previous screen
                        if (!_isVideoComplete)
                          TextButton(
                            onPressed: () {
                              _timer.cancel();
                              Get.back(result: false);
                            },
                            child: Text(
                              'cancel'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: themeController.isDarkModeActive ? Colors.grey[400] : AppColors.grey500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
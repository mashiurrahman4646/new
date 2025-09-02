import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/RegisterScreen/reg_controller.dart';
import '../Settings/appearance/ThemeController.dart';
import '../Settings/language/language_controller.dart';
import '../colors/app_colors.dart';
import '../login/login_ui/login_screen.dart';
import '../text_styles.dart';
import '../tram_and_condition/trams_and_condition_screen.dart';
 // Import your language controller

class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());
  final ThemeController themeController = Get.find<ThemeController>();


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkMode.value ? Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow-left.png',
            width: 24,
            height: 24,
            color: themeController.isDarkMode.value ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.offAll(() => LoginScreen()),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'registration'.tr,
          style: AppTextStyles.heading2.copyWith(
            color: themeController.isDarkMode.value ? Colors.white : const Color(0xFF000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProgressIndicator(context),
            const SizedBox(height: 32),
            _buildTextField(
              label: 'full_name'.tr,
              hintText: 'enter_full_name'.tr,
              controller: controller.fullNameController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'email'.tr,
              hintText: 'enter_email'.tr,
              controller: controller.emailController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'password'.tr,
              hintText: 'create_password'.tr,
              isPassword: true,
              controller: controller.passwordController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'confirm_password'.tr,
              hintText: 'reenter_password'.tr,
              isPassword: true,
              controller: controller.confirmPasswordController,
            ),
            const SizedBox(height: 24),
            Obx(() => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: controller.isTermsAccepted.value,
              onChanged: controller.toggleTermsAccepted,
              activeColor: AppColors.primary500,
              title: Text(
                'terms'.tr,
                style: AppTextStyles.bodySmall.copyWith(
                  color: themeController.isDarkMode.value ? Color(0xFF919191) : AppColors.text700,
                ),
              ),
            )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (!controller.isTermsAccepted.value) {
                    Get.snackbar(
                      'terms_required'.tr,
                      'accept_terms_message'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: themeController.isDarkMode.value ? Colors.grey[800] : Colors.red[100],
                      colorText: themeController.isDarkMode.value ? Colors.white : Colors.red[900],
                      margin: const EdgeInsets.all(12),
                    );
                    return;
                  }

                  if (controller.validateForm()) {
                    Get.toNamed('/emailVerification');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Text(
                  'continue'.tr,
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already_account".tr,
                  style: TextStyle(
                    color: themeController.isDarkMode.value ? Color(0xFF919191) : Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.to(() => LoginScreen()),
                  child: Text(
                    "login".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Get.to(() => const TermsAndConditionsScreen());
              },
              child: Text.rich(
                TextSpan(
                  text: 'terms_agreement'.tr,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: themeController.isDarkMode.value ? Color(0xFF919191) : AppColors.text700,
                  ),
                  children: [
                    TextSpan(
                      text: 'terms_conditions'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final themeController = Get.find<ThemeController>();

    return Column(
      children: [
        SizedBox(
          height: 32,
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: themeController.isDarkMode.value ? Colors.grey[800] : Colors.grey[300],
                ),
              ),
              Positioned(
                top: 15,
                left: 0,
                child: Container(
                  width: screenWidth * 0.25,
                  height: 2,
                  color: AppColors.primary500,
                ),
              ),
              Positioned(
                left: (screenWidth * 0.15) - 12,
                top: 4,
                child: _buildStepCircle(1, true),
              ),
              Positioned(
                left: (screenWidth * 0.5) - 12,
                top: 4,
                child: _buildStepCircle(2, false),
              ),
              Positioned(
                left: (screenWidth * 0.85) - 12,
                top: 4,
                child: _buildStepCircle(3, false),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth * 0.25,
              child: Text(
                'registration_step'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.primary500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.25,
              child: Text(
                'verification'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: themeController.isDarkMode.value ? Color(0xFF919191) : Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.25,
              child: Text(
                'face_id'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: themeController.isDarkMode.value ? Color(0xFF919191) : Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    final themeController = Get.find<ThemeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            color: themeController.isDarkMode.value ? Color(0xFF919191) : AppColors.text700,
            height: 1.0,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: AppTextStyles.inputText.copyWith(
            color: themeController.isDarkMode.value ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: themeController.isDarkMode.value ? Color(0xFF919191) : AppColors.text000,
              height: 1.0,
              letterSpacing: 0.0,
            ),
            filled: true,
            fillColor: themeController.isDarkMode.value ? Color(0xFF1F1F1F) : Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber, bool isActive) {
    final themeController = Get.find<ThemeController>();

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary500 :
        (themeController.isDarkMode.value ? Color(0xFF333333) : Colors.grey[400]),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          stepNumber.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
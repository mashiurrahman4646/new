import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../colors/app_colors.dart';
import '../onboarding_conroller/onboarding_controller.dart';
import '../onboarding_data.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.text50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: OnboardingData.onboardingItems.length,
                  itemBuilder: (context, index) {
                    final data = OnboardingData.onboardingItems[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Image.asset(
                            data['image'],
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          data['title'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                            color: AppColors.text900,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          data['description'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: AppColors.text500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: controller.skipToLogin,
                    child: Text(
                      "Skip",
                      style: GoogleFonts.inter(color: AppColors.text700),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: OnboardingData.onboardingItems.length,
                    effect: WormEffect(
                      dotColor: AppColors.text200,
                      activeDotColor: AppColors.primary500,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.nextPage,
                    child: Row(
                      children: [
                        Text(
                          "Continue >",
                          style: GoogleFonts.inter(color: AppColors.primary500),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

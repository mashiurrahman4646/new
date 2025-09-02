import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Settings/appearance/ThemeController.dart';
 // Import your ThemeController

// Controller for the Rate and Improve Screen
class RateAndImproveController extends GetxController {
  // Observable variable for the star rating.
  var starRating = 0.obs;

  // Method to update the star rating with "un-rate" functionality.
  void setStarRating(int rating) {
    if (starRating.value == rating) {
      starRating.value = 0; // Un-rate the star if it's already selected.
    } else {
      starRating.value = rating;
    }
  }

  // A method to handle the feedback submission.
  void submitFeedback() {
    int rating = starRating.value;

    // You would typically send the data to a backend here.
    print('Rating: $rating stars');

    // Show a success message and then navigate back.
    Get.snackbar(
      'thankYou'.tr,
      'feedbackSubmitted'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }
}

class RateAndImproveScreen extends StatelessWidget {
  const RateAndImproveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the controller instance.
    final RateAndImproveController controller = Get.put(RateAndImproveController());
    final themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: themeController.isDarkModeActive ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'rateAndImproveTitle'.tr,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w600,
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            Text(
              'saveAndGrowTogether'.tr,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w700,
                color: themeController.isDarkModeActive ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'shareYourThoughts'.tr,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(
              'rateExperience'.tr,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: themeController.isDarkModeActive ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  // Determine if the current star should be selected.
                  bool isSelected = index < controller.starRating.value;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: GestureDetector(
                      onTap: () => controller.setStarRating(index + 1),
                      child: ColorFiltered(
                        colorFilter: isSelected
                            ? const ColorFilter.mode(
                          Color(0xFF2196F3), // Blue for selected stars.
                          BlendMode.srcIn,
                        )
                            : ColorFilter.mode(
                          themeController.isDarkModeActive ? Colors.grey[600]! : Colors.grey, // Appropriate color for unselected stars.
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          'assets/icons/star.png',
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
            SizedBox(height: screenHeight * 0.03),
            Container(
              decoration: BoxDecoration(
                color: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: TextField(
                // The TextField no longer uses a controller.
                maxLines: 5,
                maxLength: 300,
                style: TextStyle(
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'feedbackHint'.tr,
                  hintStyle: TextStyle(color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey.shade500),
                  border: InputBorder.none,
                  counterText: "", // Hide the default counter.
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                onPressed: () => controller.submitFeedback(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
                ),
                child: Text(
                  'sendFeedback'.tr,
                  style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
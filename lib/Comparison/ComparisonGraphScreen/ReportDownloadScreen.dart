import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Settings/appearance/ThemeController.dart';

class ReportDownloadScreen extends StatefulWidget {
  const ReportDownloadScreen({super.key});

  @override
  State<ReportDownloadScreen> createState() => _ReportDownloadScreenState();
}

class _ReportDownloadScreenState extends State<ReportDownloadScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final bool isDarkMode = themeController.isDarkModeActive;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 20),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'report'.tr,
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xFF111827),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'exportPeriod'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode ? const Color(0xFF333333) : const Color(0xFFE5E7EB),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'monthly'.tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                      size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildOption('pdf', isDarkMode),
            const SizedBox(height: 12),
            _buildOption('CSV', isDarkMode),
            const SizedBox(height: 12),
            _buildOption('Excel.xlsx', isDarkMode),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedOption != null
                    ? () {
                  Get.back();
                  Get.snackbar(
                    'downloadStarted'.tr,
                    '${'reportBeingPrepared'.tr} ${selectedOption!}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: isDarkMode ? const Color(0xFF2E7D32) : Colors.green,
                    colorText: Colors.white,
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: isDarkMode ? const Color(0xFF333333) : const Color(0xFFE5E7EB),
                ),
                child: Text(
                  'download'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String title, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = title;
        });
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDarkMode ? const Color(0xFF333333) : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedOption == title
                      ? const Color(0xFF2563EB)
                      : isDarkMode ? const Color(0xFF555555) : const Color(0xFFD1D5DB),
                  width: 2,
                ),
              ),
              child: selectedOption == title
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2563EB),
                  ),
                ),
              )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : const Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
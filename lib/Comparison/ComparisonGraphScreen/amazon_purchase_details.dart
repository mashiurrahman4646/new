import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Settings/appearance/ThemeController.dart';
import 'ReportDownloadScreen.dart';

class AmazonPurchaseDetailsScreen extends StatelessWidget {
  const AmazonPurchaseDetailsScreen({super.key});

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
          'comparisonPage'.tr,
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xFF111827),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _storeCard(isDarkMode),
            const SizedBox(height: 20),
            _SectionTitle('priceBreakdown'.tr, isDarkMode),
            const SizedBox(height: 10),
            _priceCard(isDarkMode),
            const SizedBox(height: 20),
            _SectionTitle('purchaseSummary'.tr, isDarkMode),
            const SizedBox(height: 10),
            _summaryCard(isDarkMode),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: BorderSide(color: isDarkMode ? const Color(0xFF2563EB) : const Color(0xFF2563EB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              ),
              child: Text(
                'viewAllSaving'.tr,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2563EB),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => const ReportDownloadScreen());
              },
              icon: Image.asset(
                'assets/icons/downlodebill.png',
                height: 22,
                width: 22,
                color: Colors.white,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.download_rounded, color: Colors.white, size: 20),
              ),
              label: Text(
                'downloadPdfReport'.tr,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storeCard(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isDarkMode
              ? Image.asset(
            'assets/icons/AmazonLogo (1).png', // White Amazon logo for dark mode
            height: 36,
            width: 36,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                Icon(Icons.store_rounded, size: 28, color: isDarkMode ? Colors.white : const Color(0xFF111827)),
          )
              : Image.asset(
            'assets/icons/AmazonLogo.png', // Regular Amazon logo for light mode
            height: 36,
            width: 36,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                Icon(Icons.store_rounded, size: 28, color: isDarkMode ? Colors.white : const Color(0xFF111827)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amazon',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : const Color(0xFF111827),
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Nike Air Max 270 - Men\'s Running',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                    height: 1.25,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${'save'.tr} 23%',
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF16A34A),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceCard(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _PriceRow(
            label: 'originalPrice'.tr,
            value: '\$169.99',
            valueColor: isDarkMode ? Colors.grey[600]! : const Color(0xFF9CA3AF),
            strikeThrough: true,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 8),
          _PriceRow(
            label: 'purchasePrice'.tr,
            value: '\$129.99',
            valueColor: isDarkMode ? Colors.white : const Color(0xFF111827),
            bold: true,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 8),
          _PriceRow(
            label: 'youSaved'.tr,
            labelColor: const Color(0xFF16A34A),
            value: '\$40.00 (23%)',
            valueColor: const Color(0xFF16A34A),
            bold: true,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _SummaryRow(
            iconPath: 'assets/icons/credit-card.png',
            title: 'paymentMethod'.tr,
            value: 'VISA *****123',
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 14),
          _SummaryRow(
            iconPath: 'assets/icons/order_status.png',
            title: 'orderStatus'.tr,
            value: 'confirmed'.tr,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 14),
          _SummaryRow(
            iconPath: 'assets/icons/purchases_date.png',
            title: 'purchaseDate'.tr,
            value: 'July 30, 2025',
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 14),
          _SummaryRow(
            iconPath: 'assets/icons/order_id.png',
            title: 'orderId'.tr,
            value: '#AEX123456789',
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, this.isDarkMode);
  final String text;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? Colors.white : const Color(0xFF111827),
        height: 1.2,
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.strikeThrough = false,
    this.labelColor = const Color(0xFF111827),
    this.valueColor = const Color(0xFF111827),
    required this.isDarkMode,
  });

  final String label;
  final String value;
  final bool bold;
  final bool strikeThrough;
  final Color labelColor;
  final Color valueColor;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.grey[400] : labelColor,
              height: 1.2,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor,
              height: 1.2,
              decoration:
              strikeThrough ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.iconPath,
    required this.title,
    required this.value,
    required this.isDarkMode,
  });

  final String iconPath;
  final String title;
  final String value;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF333333) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            iconPath,
            height: 18,
            width: 18,
            color: isDarkMode ? Colors.grey[400] : null,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                Icon(Icons.help_outline, size: 16, color: isDarkMode ? Colors.grey[400]! : const Color(0xFF111827)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white : const Color(0xFF111827),
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
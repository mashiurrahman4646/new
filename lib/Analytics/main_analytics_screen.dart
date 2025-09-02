import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../homepage/main_home_page_controller.dart';
import '../reuseablenav/reuseablenavui.dart';
import 'analytics_controller.dart';
import '../../Settings/appearance/ThemeController.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalyticsController());
    final homeCtrl = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
    final themeController = Get.find<ThemeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeCtrl.selectedNavIndex.value != 1) {
        homeCtrl.selectedNavIndex.value = 1;
      }
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bool isDarkMode = themeController.isDarkModeActive;
    final Color backgroundColor = isDarkMode ? Color(0xFF121212) : Colors.white;
    final Color cardColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor = isDarkMode ? Colors.grey[400]! : Color(0xFF6A6A6A);
    final Color iconBackgroundColor = isDarkMode ? Color(0xFF2A2A2A) : Colors.grey.shade200;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(screenWidth, textColor, backgroundColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              _buildChartTypeButtons(controller, screenWidth, iconBackgroundColor, textColor),
              SizedBox(height: screenHeight * 0.03),
              _buildMonthSelector(controller, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.04),
              _buildChart(controller, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildLegend(controller, screenWidth, textColor, secondaryTextColor),
              SizedBox(height: screenHeight * 0.04),
              _buildSummaryCards(screenWidth, screenHeight, cardColor, textColor, secondaryTextColor),
              SizedBox(height: screenHeight * 0.04),
              _buildActionsSection(controller, screenWidth, screenHeight, cardColor, textColor),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        isDarkMode: isDarkMode,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth, Color textColor, Color backgroundColor) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        'analytics'.tr,
        style: TextStyle(
          color: textColor,
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: textColor),
    );
  }

  Widget _buildChartTypeButtons(AnalyticsController controller, double screenWidth, Color backgroundColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => _buildChartTypeButton('pie_chart'.tr, 0, controller, screenWidth, textColor)),
          Obx(() => _buildChartTypeButton('bar_chart'.tr, 1, controller, screenWidth, textColor)),
          Obx(() => _buildChartTypeButton('line_chart'.tr, 2, controller, screenWidth, textColor)),
        ],
      ),
    );
  }

  Widget _buildChartTypeButton(String title, int index, AnalyticsController controller, double screenWidth, Color textColor) {
    bool isSelected = controller.selectedChartType.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectChartType(index),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2196F3) : Colors.transparent,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : textColor,
              fontSize: screenWidth * 0.032,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSelector(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.012,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3).withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.getCurrentMonthAndYear(),
            style: TextStyle(
              color: const Color(0xFF2196F3),
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Icon(
            Icons.keyboard_arrow_down,
            color: const Color(0xFF2196F3),
            size: screenWidth * 0.045,
          ),
        ],
      ),
    );
  }

  Widget _buildChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Obx(() => Container(
      height: screenHeight * 0.35,
      child: controller.selectedChartType.value == 0
          ? _buildPieChart(controller, screenWidth, screenHeight)
          : controller.selectedChartType.value == 1
          ? _buildBarChart(controller, screenWidth, screenHeight)
          : _buildLineChart(controller, screenWidth, screenHeight),
    ));
  }

  Widget _buildPieChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    final pieData = controller.getCombinedChartData();
    return Center(
      child: CustomPaint(
        size: Size(screenWidth * 0.6, screenWidth * 0.6),
        painter: PieChartPainter(pieData),
      ),
    );
  }

  Widget _buildBarChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        height: screenHeight * 0.3,
        width: screenWidth * 0.85,
        child: CustomPaint(
          painter: BarChartPainter(controller.getCombinedChartData()),
        ),
      ),
    );
  }

  Widget _buildLineChart(AnalyticsController controller, double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        height: screenHeight * 0.3,
        width: screenWidth * 0.85,
        child: CustomPaint(
          painter: LineChartPainter(controller.getLineChartData()),
        ),
      ),
    );
  }

  Widget _buildLegend(AnalyticsController controller, double screenWidth, Color textColor, Color secondaryTextColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'expenses'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              ...controller.expenseData.map((data) {
                return _buildLegendItem(data.label.tr, '${data.value.toStringAsFixed(0)}%', data.color, screenWidth, textColor);
              }).toList(),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.05),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'income'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              ...controller.incomeData.map((data) {
                return _buildLegendItem(data.label.tr, '${data.value.toStringAsFixed(0)}%', data.color, screenWidth, textColor);
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, String amount, Color color, double screenWidth, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.025,
            height: screenWidth * 0.025,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Text(
              '$label: $amount',
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(double screenWidth, double screenHeight, Color cardColor, Color textColor, Color secondaryTextColor) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'total_expenses'.tr,
            '\$2012',
            Icons.arrow_downward,
            Colors.orange,
            screenWidth,
            screenHeight,
            cardColor,
            textColor,
            secondaryTextColor,
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: _buildSummaryCard(
            'total_income'.tr,
            '\$3124',
            Icons.arrow_upward,
            Colors.green,
            screenWidth,
            screenHeight,
            cardColor,
            textColor,
            secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon, Color iconColor,
      double screenWidth, double screenHeight, Color cardColor, Color textColor, Color secondaryTextColor) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: screenWidth * 0.05),
              SizedBox(width: screenWidth * 0.02),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    color: secondaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            amount,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection(AnalyticsController controller, double screenWidth, double screenHeight, Color cardColor, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'actions'.tr,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        GestureDetector(
          onTap: controller.onExpensesClick,
          child: _buildActionItem('expenses'.tr, screenWidth, cardColor, textColor),
        ),
        GestureDetector(
          onTap: controller.onIncomeClick,
          child: _buildActionItem('income'.tr, screenWidth, cardColor, textColor),
        ),
        GestureDetector(
          onTap: controller.onExportReportClick,
          child: _buildActionItem('export_report'.tr, screenWidth, cardColor, textColor),
        ),
      ],
    );
  }

  Widget _buildActionItem(String title, double screenWidth, Color cardColor, Color textColor) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.03),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: textColor.withOpacity(0.7),
            size: screenWidth * 0.04,
          ),
        ],
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<ChartData> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final innerRadius = 0.0;

    double total = data.fold(0.0, (sum, item) => sum + item.value);
    if (total == 0) return;

    double startAngle = -math.pi / 2;
    const gapAngle = 0.0;

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i].value / total) * 2 * math.pi;

      final paint = Paint()
        ..color = data[i].color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) => true;
}

class BarChartPainter extends CustomPainter {
  final List<ChartData> data;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final themeController = Get.find<ThemeController>();
    final bool isDarkMode = themeController.isDarkModeActive;
    final Color gridColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final Color textColor = isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;

    final chartHeight = size.height * 0.7;
    final chartTop = size.height * 0.1;
    final chartBottom = chartTop + chartHeight;
    final chartLeft = size.width * 0.1;
    final chartRight = size.width * 0.95;
    final chartWidth = chartRight - chartLeft;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    final maxVal = 100.0;
    final textStyle = TextStyle(
      color: textColor,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    );

    for (int i = 0; i <= 10; i++) {
      final y = chartBottom - (chartHeight * i / 10);
      canvas.drawLine(Offset(chartLeft, y), Offset(chartRight, y), gridPaint);

      final textPainter = TextPainter(
        text: TextSpan(text: '${i * 10}%', style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(2, y - textPainter.height / 2));
    }

    final totalBars = data.length;
    final barWidth = chartWidth / (totalBars * 1.5) * 0.8;
    final barGap = (chartWidth - (barWidth * totalBars)) / (totalBars + 1);
    double currentX = chartLeft + barGap;

    final categoryTextStyle = TextStyle(
      color: textColor,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    );

    for (int i = 0; i < totalBars; i++) {
      final barHeight = (data[i].value / maxVal) * chartHeight;
      final y = chartBottom - barHeight;

      final barPaint = Paint()
        ..color = data[i].color
        ..style = PaintingStyle.fill;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(currentX, y, barWidth, barHeight),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, barPaint);

      final textPainter = TextPainter(
        text: TextSpan(text: data[i].label, style: categoryTextStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final labelX = currentX + (barWidth - textPainter.width) / 2;
      final labelY = chartBottom + 8;
      textPainter.paint(canvas, Offset(labelX, labelY));

      currentX += barWidth + barGap;
    }

    final expenseLinePaint = Paint()
      ..color = const Color(0xFFFFA000)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final incomeLinePaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final lineY = chartBottom + 30;

    final expenseStart = chartLeft + barGap + (barWidth + barGap) * 0;
    final expenseEnd = chartLeft + barGap + (barWidth + barGap) * (4 - 1) + barWidth;

    final incomeStart = chartLeft + barGap + (barWidth + barGap) * 4;
    final incomeEnd = chartRight;

    canvas.drawLine(Offset(expenseStart, lineY), Offset(expenseEnd, lineY), expenseLinePaint);
    canvas.drawLine(Offset(incomeStart, lineY), Offset(incomeEnd, lineY), incomeLinePaint);

    final paintCircle = Paint()..color = const Color(0xFFFFA000)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(expenseStart, lineY), 4, paintCircle);
    canvas.drawCircle(Offset(expenseEnd, lineY), 4, paintCircle);

    paintCircle.color = const Color(0xFF4CAF50);
    canvas.drawCircle(Offset(incomeStart, lineY), 4, paintCircle);
    canvas.drawCircle(Offset(incomeEnd, lineY), 4, paintCircle);

    final labelTextStyle = TextStyle(
      color: textColor,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );

    final expenseLabelPainter = TextPainter(
      text: TextSpan(text: 'expense'.tr, style: labelTextStyle),
      textDirection: TextDirection.ltr,
    );
    expenseLabelPainter.layout();
    expenseLabelPainter.paint(canvas, Offset(expenseStart + (expenseEnd - expenseStart) / 2 - expenseLabelPainter.width / 2, lineY + 10));

    final incomeLabelPainter = TextPainter(
      text: TextSpan(text: 'income'.tr, style: labelTextStyle),
      textDirection: TextDirection.ltr,
    );
    incomeLabelPainter.layout();
    incomeLabelPainter.paint(canvas, Offset(incomeStart + (incomeEnd - incomeStart) / 2 - incomeLabelPainter.width / 2, lineY + 10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class LineChartPainter extends CustomPainter {
  final List<ChartData> data;

  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final themeController = Get.find<ThemeController>();
    final bool isDarkMode = themeController.isDarkModeActive;
    final Color gridColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final Color textColor = isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;

    final chartHeight = size.height * 0.7;
    final chartTop = size.height * 0.1;
    final chartBottom = chartTop + chartHeight;
    final chartLeft = size.width * 0.1;
    final chartRight = size.width * 0.95;
    final chartWidth = chartRight - chartLeft;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    final maxVal = 100.0;
    final textStyle = TextStyle(
      color: textColor,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    );

    for (int i = 0; i <= 10; i++) {
      final y = chartBottom - (chartHeight * i / 10);
      canvas.drawLine(Offset(chartLeft, y), Offset(chartRight, y), gridPaint);

      final textPainter = TextPainter(
        text: TextSpan(text: '${i * 10}%', style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(2, y - textPainter.height / 2));
    }

    final xLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
    final totalPoints = xLabels.length;

    final labelPaint = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    for (int i = 0; i < totalPoints; i++) {
      final x = chartLeft + (i / (totalPoints - 1)) * chartWidth;
      labelPaint.text = TextSpan(text: xLabels[i]);
      labelPaint.layout();
      final labelX = x - labelPaint.width / 2;
      final labelY = chartBottom + 8;
      labelPaint.paint(canvas, Offset(labelX, labelY)); // Fixed: changed 'cancanvas' to 'canvas'
    }

    final linePoints = [
      [60, 50, 70, 65, 75, 70, 80],
      [50, 60, 55, 65, 55, 60, 70],
      [30, 45, 40, 50, 45, 40, 50],
      [20, 25, 30, 20, 35, 30, 40],
      [25, 30, 25, 35, 30, 35, 40],
      [10, 20, 15, 25, 30, 20, 35],
    ];
    final colors = [
      const Color(0xFFFFC107),
      const Color(0xFF4CAF50),
      const Color(0xFFFF5252),
      const Color(0xFF2196F3),
      const Color(0xFF9C27B0),
      const Color(0xFF00BCD4),
    ];

    for (int i = 0; i < linePoints.length; i++) {
      final linePaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      final path = Path();
      for (int j = 0; j < linePoints[i].length; j++) {
        final x = chartLeft + (j / (linePoints[i].length - 1)) * chartWidth;
        final y = chartBottom - (linePoints[i][j] / maxVal) * chartHeight;

        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
        canvas.drawCircle(Offset(x, y), 3, linePaint..style = PaintingStyle.fill);
      }
      canvas.drawPath(path, linePaint..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
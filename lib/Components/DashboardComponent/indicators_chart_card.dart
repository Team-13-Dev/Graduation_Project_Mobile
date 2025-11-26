import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'custom_card.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';

class IndicatorsChartCard extends StatelessWidget {
  const IndicatorsChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. العنوان ومؤشر النمو
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Indicators",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Growth Earning %2.6 From Last Year",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.share, size: 20, color: AppColors.textFaded),
            ],
          ),
          const SizedBox(height: 12),

          // 3. الرسم البياني (Line Chart)
          SizedBox(height: 180, child: LineChart(_mainData())),
          const SizedBox(height: 16),

          // 2. شريط الرصيد الإجمالي
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(0.5), // خلفية أغمق قليلاً
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Net Gross(EGP 80,000)",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_upward,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      Text(
                        "+ 5.7%",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  // تهيئة بيانات الرسم البياني وخصائصه
  LineChartData _mainData() {
    return LineChartData(
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ), // إخفاء المحور الأيسر
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget:
                _bottomTitleWidgets, // استدعاء الدالة المسببة للخطأ سابقاً
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.4), // Feb
            FlSpot(2, 4.3), // Mar
            FlSpot(4, 5.2), // Apr
            FlSpot(6, 6.8), // May
            FlSpot(8, 7.5), // Jun
          ],
          isCurved: true,
          color: AppColors.primary,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.5),
                AppColors.background.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 8,
    );
  }

  // دالة عرض أسماء الأشهر (استخدام SideTitleWidget)
  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.textSecondary,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;

    // ربط القيمة الرقمية للشهر بالاسم
    switch (value.toInt()) {
      case 0:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Apr', style: style);
        break;
      case 6:
        text = const Text('May', style: style);
        break;
      case 8:
        text = const Text('Jun', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    // **هنا يتم استخدام SideTitleWidget (الذي يتطلب استيراد fl_chart)**
    return SideTitleWidget(axisSide: meta.axisSide, space: 8.0, child: text);
  }
}

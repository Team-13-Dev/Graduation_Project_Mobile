// import 'package:flutter/material.dart';
// import 'custom_card.dart';
//
// class WalletSummaryCard extends StatelessWidget {
//   const WalletSummaryCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("My Wallet",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 8),
//           const Text("\$12,400",
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {},
//             child: const Text("Withdraw Funds"),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
// **[1] ستحتاج لاستيراد هذه الحزمة لرسم الدائرة:**
import 'package:percent_indicator/percent_indicator.dart';
// **[2] يجب تعديل المسار ليناسب هيكلة مشروعك:**
import 'custom_card.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';

class WalletSummaryCard extends StatelessWidget {
  const WalletSummaryCard({super.key});

  // دالة مساعدة لبناء تفاصيل العملات (Bitcoin / USDT)
  Widget _buildCryptoDetail(String name, double percent, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, size: 10, color: color),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(color: AppColors.textSecondary)),
        const Spacer(),
        Text(
          "${(percent * 100).toStringAsFixed(0)}%",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // بيانات محاكاة مطابقة للتصميم
    const double totalBalance = 12400.0;
    const double btcPercent = 0.65; // 65%
    const Color btcColor = Color(
      0xFF00E676,
    ); // اللون الأخضر الأساسي (AppColors.primary)
    const Color usdtColor = Color(
      0xFF9E9E9E,
    ); // لون رمادي فاتح (لتمثيل اللون الثانوي في التصميم)

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. العنوان وأيقونة التقويم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "My Wallet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.calendar_today_outlined,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. الرسم البياني الدائري (Circular Progress Chart)
              CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 8.0,
                percent: btcPercent, // 65% للبيتكوين
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Balance",
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textFaded,
                      ),
                    ),
                    Text(
                      "\$${totalBalance.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                progressColor: btcColor,
                backgroundColor: usdtColor, // اللون المتبقي لـ USDT
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(width: 24),

              // 3. تفاصيل العملات (Bitcoin / USDT)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildCryptoDetail("Bitcoin", btcPercent, btcColor), // 65%
                    const SizedBox(height: 12),
                    _buildCryptoDetail(
                      "USDT",
                      (1 - btcPercent),
                      usdtColor,
                    ), // 35%
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 4. زر السحب (Withdraw Funds)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Withdraw Funds"),
            ),
          ),
        ],
      ),
    );
  }
}

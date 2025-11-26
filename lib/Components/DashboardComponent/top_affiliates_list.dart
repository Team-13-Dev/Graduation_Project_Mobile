import 'package:flutter/material.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';
import 'custom_card.dart';

class TopAffiliatesList extends StatelessWidget {
  const TopAffiliatesList({super.key});

  @override
  Widget build(BuildContext context) {
    final affiliates = [
      {"name": "Ahmed", "value": 0.8},
      {"name": "Sarah", "value": 0.6},
      {"name": "Omar", "value": 0.4},
    ];

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top Affiliates",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          ...affiliates.map((a) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a["name"] as String,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: a["value"] as double,
                  color: AppColors.primary,
                  backgroundColor: AppColors.divider,
                ),
                const SizedBox(height: 14),
              ],
            );
          }),
        ],
      ),
    );
  }
}

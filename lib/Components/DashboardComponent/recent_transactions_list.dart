import 'package:flutter/material.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';
import 'custom_card.dart';

class RecentTransactionsList extends StatelessWidget {
  const RecentTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        "title": "Payment from John",
        "amount": "+\$320",
        "color": AppColors.success,
      },
      {
        "title": "Refund to Client",
        "amount": "-\$120",
        "color": AppColors.error,
      },
      {"title": "New Order", "amount": "+\$89", "color": AppColors.success},
    ];

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Transactions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          ...transactions.map((e) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(e["title"], style: const TextStyle(fontSize: 15)),
              trailing: Text(
                e["amount"],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: e["color"],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

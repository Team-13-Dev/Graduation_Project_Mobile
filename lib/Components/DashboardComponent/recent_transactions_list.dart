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
        "date": "Oct 6, 2025",
        "status": "Completed",
        "statuscolor": AppColors.success,
        "amount": "+ 2000 EGP",
        "color": AppColors.success,
      },
      {
        "title": "Refund to Client",
        "date": "Feb 15, 2024",
        "status": "Completed",
        "statuscolor": AppColors.success,
        "amount": "- 450.00 EGP",
        "color": AppColors.error,
      },
      {
        "title": "New Order",
        "date": "Jan 21, 2020",
        "status": "Pending",
        "statuscolor": AppColors.walletOrange,
        "amount": "+ 200.00 EGP",
        "color": AppColors.success,
      },
    ];

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Transactions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          /// ---------- TABLE HEADER ----------
          Row(
            children: const [
              Expanded(
                flex: 3,
                child: Text(
                  "TRANSACTION",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "DATE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "STATUS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "AMOUNT",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ...List.generate(transactions.length, (index) {
            final e = transactions[index];
            final bool isEvenRow = index % 2 == 0;

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isEvenRow
                    ? Colors.grey.withOpacity(0.06)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      e["title"],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      e["date"],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: e["statuscolor"],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(e["status"], style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      e["amount"],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: e["color"],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

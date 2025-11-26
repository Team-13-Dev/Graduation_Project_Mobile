import 'package:flutter/material.dart';

import 'package:fuse/Components/DashboardComponent/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

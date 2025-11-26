import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';

// ignore: must_be_immutable
class CustomGoogleButton extends StatelessWidget {
  void Function()? onTap;
  String buttname;
  CustomGoogleButton({required this.onTap, required this.buttname, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.divider.withOpacity(0.3),
          border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google.png", width: 35),
            SizedBox(width: 10.w),
            Text(
              buttname,
              style: TextStyle(
                color: const Color(0xFFF1F5F9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';

class Customsignbutton extends StatelessWidget {
  void Function()? onTap;
  bool loading;
  String buttonname;
  Customsignbutton({
    super.key,
    required this.onTap,
    required this.loading,
    required this.buttonname,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1, color: Colors.white.withOpacity(0.15)),
        ),
        child: Center(
          child: loading
              ? SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonname,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.arrow_right_rounded),
                  ],
                ),
        ),
      ),
    );
  }
}

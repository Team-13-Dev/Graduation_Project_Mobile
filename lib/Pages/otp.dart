import 'dart:async';
import 'dart:ui';
import 'package:clerk_auth/clerk_auth.dart' as auth;
import 'package:clerk_flutter/clerk_flutter.dart' as clerk;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';
import 'package:fuse/Pages/dashboard_screen.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  late final clerk.ClerkAuthState _auth;
  bool _authInitialized = false;
  bool isloading = false;
  bool _isTrue = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!(_authInitialized)) {
      _auth = clerk.ClerkAuth.of(context); // ✅ initialize _auth here
      _authInitialized = true;
    }
  }

  Future<void> _verifySignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isTrue = true;
        isloading = true;
      });
      String otp = _otpControllers.map((c) => c.text).join();
      try {
        await _auth.attemptSignUp(strategy: auth.Strategy.emailCode, code: otp);
      } catch (e) {
        setState(() {
          _isTrue = false;
          isloading = false;
        });
        if (mounted) {
          setState(() {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          });
        }
      } finally {
        if (_isTrue) {
          isloading = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (route) => false,
          );
        }
      }
    }
  }

  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 0.92.sw,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(width: 1, color: AppColors.divider),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "OTP Verification",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Enter the 6-digit code sent to your phone",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 30.h),

                      /// OTP Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 45.w,
                            height: 60.h,
                            child: TextFormField(
                              controller: _otpControllers[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLength: 1,
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.divider,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.05),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              onChanged: (val) {
                                if (val.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 30.h),
                      TextButton(
                        onPressed: () {
                          for (var controller in _otpControllers) {
                            controller.clear();
                          }
                          setState(() {});
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      /// Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: AppColors.divider),
                            backgroundColor: AppColors.cardBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: _verifySignUp,
                          child: isloading
                              ? CircularProgressIndicator()
                              : Text(
                                  "Verify",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    _authInitialized = false;

    super.dispose();
  }
}

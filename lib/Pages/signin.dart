import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _obsecuretext = true;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  //Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Submit all function
  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Form Submitted Successfully ✅")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 0.85.sw,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    width: 1,
                    // ignore: deprecated_member_use
                    color: const Color(0xFF0284C7).withOpacity(0.3),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Join the community today',
                        style: TextStyle(
                          color: const Color(0xFFF1F5F9),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Google button
                      _buildGoogleButton(),
                      SizedBox(height: 16.h),
                      Text(
                        'or',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFFF1F5F9),
                        ),
                      ),
                      SizedBox(height: 25.h),

                      // Email
                      _buildTextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is Required';
                          } else if (!RegExp(
                            r'^[^@]+@[^@]+\.[^@]+',
                          ).hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        hint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.h),

                      // Password
                      _buildTextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is Required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        hint: 'Password',
                        obsecuretext: _obsecuretext,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obsecuretext
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            setState(() {
                              _obsecuretext = !_obsecuretext;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // Sign up button
                      _buildSignupButton(),
                      SizedBox(height: 16.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a member?',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFFF1F5F9),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildSignupButton() {
    return GestureDetector(
      onTap: () {
        _submit();
      },
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          color: const Color(0xFF003091),
          borderRadius: BorderRadius.circular(30.r),
          // ignore: deprecated_member_use
          border: Border.all(width: 1, color: Colors.white.withOpacity(0.15)),
        ),
        child: Center(
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        // ignore: deprecated_member_use
        color: const Color(0xFF003091).withOpacity(0.3),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mail, size: 20.sp, color: Colors.white),
          SizedBox(width: 10.w),
          Text(
            'Use Google account',
            style: TextStyle(
              color: const Color(0xFFF1F5F9),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    bool obsecuretext = false,
    required TextInputType keyboardType,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obsecuretext,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
        suffixIcon: suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:ui';
import 'package:clerk_auth/clerk_auth.dart' as auth;
import 'package:clerk_flutter/clerk_flutter.dart' as clerk;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuse/Components/AuthComponent/customgooglebutton.dart';
import 'package:fuse/Components/AuthComponent/customsignbutton.dart';
import 'package:fuse/Components/AuthComponent/customtextfield.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';
import 'package:fuse/Pages/dashboard_screen.dart';
import 'package:fuse/Pages/otp.dart';
import 'package:fuse/Pages/signin.dart';
import 'package:fuse/auth/clerk_oauth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obsecuretext = true;
  bool _loading = false;

  bool _authInitialized = false;

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final clerk.ClerkAuthState _auth;
  late final StreamSubscription _errorSub;
  // auth.User? _user;
  final oauth = ClerkOAuth();
  bool _isTrue = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!(_authInitialized)) {
      _auth = clerk.ClerkAuth.of(context); // ✅ initialize _auth here
      // _user = _auth.user;
      // _auth.addListener(_updateUser);
      _errorSub = _auth.errorStream.listen((err) {
        setState(() {
          _isTrue = false;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err.message)));
        });
      });
      _authInitialized = true;
    }
  }

  // void _updateUser() {
  //   if (!mounted) return;
  //   setState(() {
  //     _user = _auth.user;
  //   });
  // }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        //  _isTrue = true;
      });
      try {
        await _auth.attemptSignUp(
          strategy: auth.Strategy.password,
          emailAddress: _emailController.text,
          password: _passwordController.text,
          passwordConfirmation: _passwordController.text,
        );
      } finally {
        await Future.delayed(Duration(seconds: 3));
        setState(() {
          _loading = false;
        });
        if (_isTrue) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtpPage()),
          );
        }
        setState(() {
          _isTrue = true;
        });
      }
    }
  }

  Future<void> signupByGoogle() async {
    setState(() {
      _loading = true;
    });
    try {
      // This will sign up or sign in the user with Google
      await _auth.ssoSignIn(context, auth.Strategy.oauthGoogle);
      await Future.delayed(Duration(seconds: 1));

      // Session is created; navigate to Dashboard
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    } catch (e) {
      print('Google OAuth failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Google sign-up failed')));
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

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
                width: 0.85.sw,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    width: 1,
                    // ignore: deprecated_member_use
                    color: AppColors.textFaded.withOpacity(0.3),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SvgPicture.asset(
                        'assets/images/fuse.svg',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Sign up to fuse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Welcome to our community today!',
                        style: TextStyle(
                          color: const Color(0xFFF1F5F9),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Google button
                      CustomGoogleButton(
                        onTap: () {
                          signupByGoogle();
                        },
                        buttname: "Continue with Google",
                      ),
                      SizedBox(height: 16.h),

                      // Email
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email address"),
                          SizedBox(height: 10.h),

                          Customtextfield(
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
                          SizedBox(height: 12.h),
                          Text("Password"),
                          SizedBox(height: 10.h),

                          // Password
                          Customtextfield(
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
                        ],
                      ),

                      SizedBox(height: 30.h),
                      // Sign up button
                      Customsignbutton(
                        buttonname: "Continue",
                        loading: _loading,
                        onTap: () {
                          if (_loading) return null;
                          _signUp();
                        },
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: AppColors.divider,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already i have an account?',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFFF1F5F9),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          TextButton(
                            onPressed: () {},
                            child: TextButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signin(),
                                ),
                                (route) => false,
                              ),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authInitialized = false;
    _errorSub.cancel();
    super.dispose();
  }
}

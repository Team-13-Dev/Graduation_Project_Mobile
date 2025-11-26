import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clerk_flutter/clerk_flutter.dart' as clerk;
import 'package:clerk_auth/clerk_auth.dart' as auth;
import 'package:fuse/Pages/dashboard_screen.dart';
import 'package:fuse/Pages/signin.dart';
import 'package:fuse/Components/DashboardComponent/app_themes.dart';

//pk_test_Zmx1ZW50LWFzcC0yMi5jbGVyay5hY2NvdW50cy5kZXYk my test publish key
//pk_test_Y29taWMtbXVkZmlzaC0xNC5jbGVyay5hY2NvdW50cy5kZXYk real publish key

void main() async {
  runApp(const Fuse());
}

class Fuse extends StatelessWidget {
  const Fuse({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return clerk.ClerkAuth(
          config: clerk.ClerkAuthConfig(
            publishableKey:
                "pk_test_Zmx1ZW50LWFzcC0yMi5jbGVyay5hY2NvdW50cy5kZXYk",
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.darkTheme,

            home: clerk.ClerkErrorListener(
              child: clerk.ClerkAuthBuilder(
                signedInBuilder: (context, authState) {
                  return const DashboardScreen();
                },
                signedOutBuilder: (context, authState) {
                  return const Signin();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

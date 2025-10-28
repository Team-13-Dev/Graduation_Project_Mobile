import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuse/Pages/signin.dart';

void main() {
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
      builder: (context, child) =>
          MaterialApp(debugShowCheckedModeBanner: false, home: Signin()),
    );
  }
}

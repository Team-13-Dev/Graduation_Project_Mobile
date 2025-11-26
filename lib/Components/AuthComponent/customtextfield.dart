import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Customtextfield extends StatelessWidget {
  TextEditingController controller;
  String hint;
  bool? obsecuretext = false;
  TextInputType keyboardType;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  Customtextfield({
    super.key,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.obsecuretext,
    this.suffixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obsecuretext ?? false,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        //hintText: hint,
        hintStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }
}

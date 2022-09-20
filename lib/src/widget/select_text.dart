import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSelectText extends StatelessWidget {
  final String label;
  const CustomSelectText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 15.sp),
    );
  }
}

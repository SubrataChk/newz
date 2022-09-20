import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class tabSection extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color colors;
  final double fontSize;
  const tabSection(
      {Key? key,
      required this.colors,
      required this.onTap,
      required this.title,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colors,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}

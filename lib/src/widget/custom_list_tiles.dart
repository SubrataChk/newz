import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTiles extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icons;
  const CustomListTiles(
      {Key? key, required this.icons, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icons,
          size: 28.w,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
        ),
      ),
    );
  }
}

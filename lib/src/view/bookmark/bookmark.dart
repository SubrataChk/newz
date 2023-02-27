import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newz/src/widget/artical.dart';

import '../../widget/utils.dart';

class BookMarkPageSection extends StatelessWidget {
  const BookMarkPageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Bookmarks",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18.sp, color: color),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Upcoming Feature ",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
          ),
        )
        // ListView.builder(
        // itemCount: 10,
        // itemBuilder: (context, index) {
        // return ArticleSection();
        // }),
        );
  }
}

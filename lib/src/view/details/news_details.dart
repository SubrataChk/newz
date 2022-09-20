import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newz/src/model/news_model.dart';
import 'package:newz/src/provider/news_provider.dart';
import 'package:newz/src/widget/select_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

import '../../widget/error_show.dart';
import '../../widget/utils.dart';

class NewsDetailsSection extends StatelessWidget {
  final NewModel data;
  const NewsDetailsSection({super.key, required this.data});

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
          "NewZ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.sp, color: color),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.dateToShow,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    Text(
                      data.readingTimeText,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.w),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.w),
                    child: Hero(
                      tag: data.publishedAt,
                      child: FancyShimmerImage(
                          height: 220.h,
                          width: double.infinity,
                          imageUrl: data.urlToImage),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 15,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          try {
                            Share.share(data.url, subject: "Look what I made");
                          } catch (e) {
                            showMessage(e.toString(), context);
                            ;
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              Icons.share,
                              size: 25.w,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              Icons.bookmark,
                              size: 25.w,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomSelectText(label: data.description),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Content",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomSelectText(label: data.content)
              ],
            ),
          )
        ],
      )),
    );
  }
}

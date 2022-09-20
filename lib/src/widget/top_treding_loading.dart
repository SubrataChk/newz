import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TopTrendingLoading extends StatefulWidget {
  const TopTrendingLoading({super.key});

  @override
  State<TopTrendingLoading> createState() => _TopTrendingLoadingState();
}

class _TopTrendingLoadingState extends State<TopTrendingLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Material(
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12.w),
                  child: Container(
                    height: 300.h,
                    width: double.infinity,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Title",
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
                ),
              ),
              FittedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            size: 20.w,
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SelectableText("20-2-2022")
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

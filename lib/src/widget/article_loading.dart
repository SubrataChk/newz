import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ArticleLoadingWidget extends StatefulWidget {
  const ArticleLoadingWidget({super.key});

  @override
  State<ArticleLoadingWidget> createState() => _ArticleLoadingWidgetState();
}

class _ArticleLoadingWidgetState extends State<ArticleLoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18.w);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w)),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        padding: EdgeInsets.all(9),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.red),
                                height: 90.h,
                                width: 90.w,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: borderRadius,
                                        color: Colors.red),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                      height: 20.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: borderRadius,
                                          color: Colors.red)),
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipOval(
                                            child: Container(
                                              height: 30.h,
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: 20.h,
                                            width: 220.w,
                                            decoration: BoxDecoration(
                                                borderRadius: borderRadius,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              );
            }));
  }
}

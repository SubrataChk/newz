import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newz/src/model/news_model.dart';
import 'package:newz/src/view/details/news_details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../view/details/web_view.dart';

class TopTrending extends StatefulWidget {
  const TopTrending({super.key});

  @override
  State<TopTrending> createState() => _TopTrendingState();
}

class _TopTrendingState extends State<TopTrending> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewModel>(context);
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetailsSection(
                          data: newsProvider,
                        )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                child: Hero(
                  tag: newsProvider.publishedAt,
                  child: FancyShimmerImage(
                      height: 300.h,
                      width: double.infinity,
                      boxFit: BoxFit.fill,
                      imageUrl: newsProvider.urlToImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  newsProvider.title,
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
              ),
              FittedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    ctx: context,
                                    child: NewsDetailsWeb(
                                      url: newsProvider.url,
                                    ),
                                    type: PageTransitionType.rightToLeft));
                          },
                          icon: Icon(
                            Icons.web_rounded,
                            size: 25.w,
                          )),
                      // SizedBox(
                      // width: 60.w,
                      // ),
                      SelectableText(
                        newsProvider.dateToShow,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15.sp),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

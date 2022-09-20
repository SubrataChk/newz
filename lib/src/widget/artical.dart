import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newz/src/model/news_model.dart';
import 'package:newz/src/view/details/news_details.dart';
import 'package:newz/src/view/details/web_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ArticleSection extends StatefulWidget {
  // final String title;
  // final String imageUrl;
  // final String url;
  // final String dateTime;
  // final String readingTime;
  const ArticleSection({
    super.key,
    // required this.imageUrl,
    // required this.url,
    // required this.title,
    // required this.dateTime,
    // required this.readingTime,
  });

  @override
  State<ArticleSection> createState() => _ArticleSectionState();
}

class _ArticleSectionState extends State<ArticleSection> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  ctx: context,
                  child: NewsDetailsSection(
                    data: newsProvider,
                  ),
                  type: PageTransitionType.rightToLeft));
        },
        child: Card(
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.w)),
            child: Container(
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: newsProvider.publishedAt,
                      child: FancyShimmerImage(
                        imageUrl: newsProvider.urlToImage,
                        height: 90.h,
                        width: 90.w,
                        boxFit: BoxFit.cover,
                      ),
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
                        Text(
                          newsProvider.title,
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.punch_clock),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                newsProvider.readingTimeText,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
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
                                            type: PageTransitionType
                                                .rightToLeft));
                                  },
                                  icon: Icon(
                                    Icons.web_rounded,
                                    size: 20.w,
                                  )),
                              Text(
                                newsProvider.dateToShow,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

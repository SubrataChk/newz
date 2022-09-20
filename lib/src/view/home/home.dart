import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newz/src/global/value.dart';
import 'package:newz/src/model/news_model.dart';
import 'package:newz/src/provider/news_provider.dart';
import 'package:newz/src/service/api_service.dart';
import 'package:newz/src/view/home/theme.dart';
import 'package:newz/src/view/search/search.dart';
import 'package:newz/src/widget/artical.dart';
import 'package:newz/src/widget/drawer.dart';
import 'package:newz/src/widget/article_loading.dart';
import 'package:newz/src/widget/top_treding_loading.dart';
import 'package:newz/src/widget/top_trending.dart';
import 'package:newz/src/widget/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../widget/tab_section.dart';

class HomePageSection extends StatefulWidget {
  const HomePageSection({super.key});

  @override
  State<HomePageSection> createState() => _HomePageSectionState();
}

class _HomePageSectionState extends State<HomePageSection> {
  var newsType = NewsType.allNews;
  // List<NewModel> newsList = [];
  int currentpage_index = 0;
  var sortBy = SortByName.PublishedAt.name;

  @override
  void initState() {
    // getNewsList();
    super.initState();
  }

  // Future<List<NewModel>> getNewsList() async {
  // List<NewModel> newsList = await ApiService.getNews();
  // return newsList;
  // }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        ctx: context,
                        child: SearchPageSection(),
                        type: PageTransitionType.rightToLeft));
              },
              icon: Icon(
                CupertinoIcons.search,
                size: 20.w,
              ))
        ],
      ),
      drawer: DrawerSection(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                tabSection(
                  title: "All News",
                  colors: newsType == NewsType.allNews
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  onTap: () {
                    if (newsType == NewsType.allNews) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.allNews;
                    });
                  },
                  fontSize: newsType == NewsType.allNews ? 22.sp : 14.sp,
                ),
                SizedBox(
                  width: 20.w,
                ),
                tabSection(
                  title: "Top Trending",
                  colors: newsType == NewsType.topTrending
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  onTap: () {
                    if (newsType == NewsType.topTrending) {
                      return;
                    }

                    setState(() {
                      newsType = NewsType.topTrending;
                    });
                  },
                  fontSize: newsType == NewsType.topTrending ? 22.sp : 14.sp,
                ),
              ],
            ),
            newsType == NewsType.topTrending
                ? Container()
                : SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        paginationWidget(
                            onTap: () {
                              if (currentpage_index == 0) {
                                return;
                              } else {
                                setState(() {
                                  currentpage_index -= 1;
                                });
                              }
                            },
                            title: "Prev"),
                        Flexible(
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: currentpage_index == index
                                      ? Colors.blue
                                      : Theme.of(context).cardColor,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentpage_index = index;
                                      });
                                    },
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentpage_index = index;
                                            });
                                          },
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(fontSize: 18.sp),
                                          )),
                                    )),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        paginationWidget(
                            onTap: () {
                              if (currentpage_index == 4) {
                                return;
                              } else {
                                setState(() {
                                  currentpage_index += 1;
                                });
                              }
                            },
                            title: "Next"),
                      ],
                    ),
                  ),
            SizedBox(
              height: 10.h,
            ),
            newsType == NewsType.topTrending
                ? Container()
                : Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.w)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                            value: sortBy,
                            items: dropDownItems,
                            onChanged: (String? value) {
                              setState(() {
                                sortBy = value!;
                              });
                            }),
                      ),
                    ),
                  ),
            Divider(),
            FutureBuilder<List<NewModel>?>(
                future: newsType == NewsType.allNews
                    ? newsProvider.fetchAllNews(
                        context: context,
                        pageIndex: currentpage_index + 1,
                        sortBy: sortBy)
                    : newsProvider.getTopHeadlines(context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return newsType == NewsType.allNews
                        ? ArticleLoadingWidget()
                        : TopTrendingLoading();
                  } else if (snapshot.hasError) {
                    return Expanded(child: Text("There is some Error"));
                  } else if (snapshot.hasData == null) {
                    return Expanded(child: Text("No News Found"));
                  }
                  return newsType == NewsType.allNews
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ChangeNotifierProvider.value(
                                  value: snapshot.data![index],
                                  child: ArticleSection(
                                      // title: snapshot.data![index].title,
                                      // imageUrl: snapshot.data![index].urlToImage,
                                      // url: snapshot.data![index].url,
                                      // dateTime: snapshot.data![index].dateToShow,
                                      // readingTime:
                                      // snapshot.data![index].readingTimeText,
                                      ),
                                );
                              }))
                      : SizedBox(
                          height: 500.h,
                          child: Swiper(
                            autoplay: true,
                            autoplayDelay: 8000,
                            itemCount: snapshot.data!.length,
                            itemWidth: MediaQuery.of(context).size.width * 0.9,
                            viewportFraction: 0.9,
                            layout: SwiperLayout.DEFAULT,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                  value: snapshot.data![index],
                                  child: TopTrending());
                            },
                          ),
                        );
                })
          ],
        ),
      )),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: SortByName.Relevancy.name,
          child: Text(
            SortByName.Relevancy.name,
          )),
      DropdownMenuItem(
          value: SortByName.Popularity.name,
          child: Text(
            SortByName.Popularity.name,
          )),
      DropdownMenuItem(
          value: SortByName.PublishedAt.name,
          child: Text(
            SortByName.PublishedAt.name,
          ))
    ];
    return menuItems;
  }

  Widget paginationWidget({
    required VoidCallback onTap,
    required String title,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(6),
        primary: Colors.blue,
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

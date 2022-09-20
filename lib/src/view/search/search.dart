import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newz/src/global/value.dart';
import 'package:newz/src/provider/news_provider.dart';
import 'package:newz/src/widget/no_data_found.dart';
import 'package:provider/provider.dart';

import '../../model/news_model.dart';

class SearchPageSection extends StatefulWidget {
  const SearchPageSection({super.key});

  @override
  State<SearchPageSection> createState() => _SearchPageSectionState();
}

class _SearchPageSectionState extends State<SearchPageSection> {
  TextEditingController _searchController = TextEditingController();
  FocusNode? focusNode;

  @override
  void initState() {
    _searchController;
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _searchController.dispose();
      focusNode!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          focusNode!.unfocus();
        });
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        focusNode!.unfocus();
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 22.w,
                      )),
                  Flexible(
                      child: TextFormField(
                    focusNode: focusNode,
                    controller: _searchController,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    onEditingComplete: () async {
                      await newsProvider.searchNews(
                          context: context, query: _searchController.text);
                      focusNode!.unfocus();
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        hintText: "Search",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          focusNode!.unfocus();
                        });
                      },
                      icon: Icon(Icons.clear, color: Colors.red))
                ],
              ),
            ),
            Expanded(
              child: MasonryGridView.count(
                  itemCount: searchKeyword.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.w),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(6.w)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              searchKeyword[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            NoDataFound(),
          ],
        ),
      )),
    );
  }
}

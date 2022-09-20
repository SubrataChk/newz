import 'package:flutter/material.dart';
import 'package:newz/src/model/news_model.dart';
import 'package:newz/src/service/api_service.dart';

class NewsProvider with ChangeNotifier {
  List<NewModel>? newsList = [];

  List<NewModel> get getNewsList => newsList!;

  Future<List<NewModel>> fetchAllNews(
      {required BuildContext context,
      required int pageIndex,
      required String sortBy}) async {
    newsList = await ApiService.getNews(
        page: pageIndex, context: context, sortBy: sortBy);

    return newsList!;
  }

  Future<List<NewModel>> getTopHeadlines({
    required BuildContext context,
  }) async {
    newsList = await ApiService.getTopNews(context: context);
    return newsList!;
  }

  Future<List<NewModel>> searchNews(
      {required BuildContext context, required String query}) async {
    newsList = await ApiService.searchNews(context: context, query: query);
    return newsList!;
  }
}

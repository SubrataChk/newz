import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newz/src/global/apikey.dart';
import 'package:newz/src/global/http_error.dart';
import 'package:newz/src/global/value.dart';
import 'package:newz/src/model/news_model.dart';
import 'package:newz/src/widget/error_show.dart';

class ApiService {
  static Future<List<NewModel>?> getNews(
      {required BuildContext context,
      required int page,
      required String sortBy}) async {
    try {
      //<List<NewModel>>
      // var url = Uri.parse(
      // "https://newsapi.org/v2/everything?q=keyword&apiKey=f62194bd2b334614b9dff8bbe9f1cc70");
      var url = Uri.https(baseUrl, "v2/everything", {
        "q": "everything",
        "pageSize": "5",
        "domains": "bbc.co.uk,techcrunch.com,engadget.com",
        // "apiKEY": ApiKey.apiKey,
        "page": page.toString(),
        "sortBy": sortBy
      });
      var response = await http.get(url, headers: {"X-Api-Key": ApiKey.apiKey});
      var data = jsonDecode(response.body.toString());
      if (data["code"] != null) {
        // ignore: use_build_context_synchronously
        throw HttpException(codeMessage: data["code"], context: context);
      } else {
        List newsList = [];
        for (var newData in data["articles"]) {
          newsList.add(newData);
        }
        return NewModel.newsFromSnapshot(newsList);
      }
    } catch (e) {
      showMessage(e.toString(), context);
    }
  }

  static Future<List<NewModel>?> getTopNews({
    required BuildContext context,
  }) async {
    try {
      //<List<NewModel>>
      // var url = Uri.parse(
      // "https://newsapi.org/v2/everything?q=keyword&apiKey=f62194bd2b334614b9dff8bbe9f1cc70");
      var url = Uri.https(baseUrl, "v2/top-headlines", {"country": 'us'});
      var response = await http.get(url, headers: {"X-Api-Key": ApiKey.apiKey});
      var data = jsonDecode(response.body.toString());
      if (data["code"] != null) {
        // ignore: use_build_context_synchronously
        throw HttpException(codeMessage: data["code"], context: context);
      } else {
        List newsList = [];
        for (var newData in data["articles"]) {
          newsList.add(newData);
        }
        return NewModel.newsFromSnapshot(newsList);
      }
    } catch (e) {
      showMessage(e.toString(), context);
    }
  }

  static Future<List<NewModel>?> searchNews({
    required BuildContext context,
    required String query,
  }) async {
    try {
      var url = Uri.https(baseUrl, "v2/everything", {
        "q": query,
        "pageSize": "10",
        "domains": "bbc.co.uk,techcrunch.com,engadget.com",
      });
      var response = await http.get(url, headers: {"X-Api-Key": ApiKey.apiKey});
      var data = jsonDecode(response.body.toString());
      if (data["code"] != null) {
        // ignore: use_build_context_synchronously
        throw HttpException(codeMessage: data["code"], context: context);
      } else {
        List newsList = [];
        for (var newData in data["articles"]) {
          newsList.add(newData);
        }
        return NewModel.newsFromSnapshot(newsList);
      }
    } catch (e) {
      showMessage(e.toString(), context);
    }
  }
}

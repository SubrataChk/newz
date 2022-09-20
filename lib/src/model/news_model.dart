import 'package:flutter/cupertino.dart';
import 'package:reading_time/reading_time.dart';

import '../global/value.dart';

class NewModel extends ChangeNotifier {
  String newsId;
  String source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String dateToShow;
  String content;
  String readingTimeText;
  NewModel({
    required this.newsId,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.dateToShow,
    required this.content,
    required this.readingTimeText,
  });

  factory NewModel.fromJson(dynamic json) {
    var title = json["title"] ?? "";
    var description = json["description"] ?? "";
    var content = json["content"] ?? "";
    String dateToShow = formatDate(json["publishedAt"]);
    if (json["publishedAt"] != null) {
      String dateToShow = formatDate(json["publishedAt"]);
    }
    return NewModel(
      newsId: json["source"]["id"] ?? "",
      source: json["source"]["name"] ?? "",
      author: json["author"] ?? "",
      title: title,
      description: description,
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: json["publishedAt"] ?? "",
      dateToShow: dateToShow,
      content: content,
      readingTimeText: readingTime(title + description + content * 50).msg,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["source"] = newsId;
    data["source"] = source;
    data["author"] = author;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["publishedAt"] = publishedAt;
    data["dateToShow"] = dateToShow;
    data["content"] = content;
    data["readingTimeText"] = readingTimeText;
    return data;
  }

  static List<NewModel> newsFromSnapshot(List snapshot) {
    return snapshot.map((e) {
      return NewModel.fromJson(e);
    }).toList();
  }

  @override
  String toString() {
    return "News {newsId: $newsId }";
  }
}

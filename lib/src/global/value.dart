import 'package:intl/intl.dart';

enum NewsType { topTrending, allNews }

enum SortByName {
  Relevancy,
  Popularity,
  PublishedAt,
}

const List<String> searchKeyword = [
  "Football",
  "Python",
  "Flutter",
  "Weather",
  "Bitcoin",
  "Youtube"
];

String baseUrl = "newsapi.org";

String formatDate(var publishedAt) {
  DateTime parseDate = DateTime.parse(publishedAt);
  String dateFormat = DateFormat("yyyy-mm-dd hh:mm:ss").format(parseDate);
  DateTime publishDate = DateFormat("yyyy-mm-dd hh:mm:ss").parse(dateFormat);
  return "${publishDate.day}/${publishDate.month}/${publishDate.year} on ${publishDate.hour}:${publishDate.minute}";
}

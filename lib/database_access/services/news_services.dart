import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_project/database_access/Apis/apis.dart';

import '../problem_domains/news.dart';

class NewsServices {
  Future<List<News>> fetchNews() async {
    // Fetching the data from server
    http.Response response = await http.get(NEWS_API);

    // Decoding data we fetched previously
    Map<String, dynamic> responseObj =
        json.decode(response.body) as Map<String, dynamic>;
    List responseNewsObj = responseObj['articles'];
    List<News> _newsList = [];
    // Assigning the news data to the list for bloc
    if (responseObj.isNotEmpty) {
      for (var newsData in responseNewsObj) {
        News _news = News.fromJson(newsData);
        _newsList.add(_news);
      }
    }
    return _newsList;
  }
}

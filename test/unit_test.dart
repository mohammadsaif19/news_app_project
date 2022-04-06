import 'package:flutter_test/flutter_test.dart';
import 'package:news_project/database_access/problem_domains/news.dart';
import 'package:news_project/database_access/services/news_services.dart';

final NewsServices _newsService = NewsServices();

void main() {
  // This unit test will check the list of news from api is successfully fetched ot not
  test("Unit test for fetching the news from Api", () async {
    List<News> _news = await _newsService.fetchNews();

    // True means our news service api return a list which contains more than one articles
    expect(_news.isNotEmpty, true);
  });
}

// Please run "flutter test" cmd in terminal to run the above unit test for news service api
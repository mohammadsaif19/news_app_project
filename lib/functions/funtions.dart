import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_project/const/const.dart';
import 'package:news_project/database_access/problem_domains/news.dart';

// I used different font family for different language and
// this funtions will return the exact font family
// I want based on current language
String getFontFamily(BuildContext context) {
  Locale currentLocale = context.locale;
  int indexOfLocale = localiesList.indexOf(currentLocale);
  return fontFamilyNames[indexOfLocale];
}

//Navigator shortcuts for easy routing
Future pushToWithAnimation(BuildContext context, Widget widget) async {
  return Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => widget,
    ),
  );
}

Future pushTo(BuildContext context, Widget widget) async {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => widget,
    ),
  );
}

pop(BuildContext context) => Navigator.pop(context);

// Converting the date into human-readable date
String getDate(News news) {
  DateTime _dateTime = DateTime.parse(news.publishedAt.toString());
  String _date = DateFormat().add_yMMMd().format(_dateTime);
  return _date;
}

// Converting the time into human-readable time
String getTime(News news) {
  DateTime _dateTime = DateTime.parse(news.publishedAt.toString());
  String _time = DateFormat().add_jm().format(_dateTime);
  return _time;
}

// This funtions used for make artifical delay
// while running integration testing
Future delayTill(int duration) async {
  return await Future.delayed(Duration(seconds: duration));
}

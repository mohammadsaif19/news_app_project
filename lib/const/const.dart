// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Following list are used for making localization
const List<Locale> localiesList = [
  Locale('bn', 'BD'),
  Locale('ar', 'SA'),
  Locale('en', 'US'),
];

const List<String> localiesCountryNames = [
  "বাংলা",
  "العربية",
  "English",
];

const List<String> fontFamilyNames = [
  "Bengali",
  "Cairo",
  "Poppins",
];

// Following keys are used for integration test to recognize the specific widget
const Key BREAKING_NEWS_LISTVIEW_KEY = Key("BreakingNewsKey");
const Key LATEST_NEWS_LISTVIEW_KEY = Key("LatestNewsKey");
const Key CHANGE_LANGUAGES_KEY = Key("ChangeLanguagesKey");
const Key CHANGE_LANGUAGES_LIST_KEY = Key("ChangeLanguagesListKey");

const Key SHOW_MORE_BUTTON_KEY = Key("ShowMoreKey");
const Key BACK_BUTTON_FROM_NEWS_KEY = Key("BackButtonKey");
const Key LOADING_KEY = Key("LoadingKey");
const Key FAVORITE_KEY = Key("FavoriteKey");

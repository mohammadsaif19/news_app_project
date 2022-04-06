// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> bn = {
    "app_title": "দ্য মর্নিং নিউজ",
    "breaking_news_title": "সদ্যপ্রাপ্ত সংবাদ",
    "latest_news_title": "সর্বশেষ সংবাদ",
    "more_text": "আরও",
    "show_all_text": "সব দেখুন",
    "save_text": "সম্পন্ন",
    "change_language_title": "ভাষা পরিবর্তন করুন",
    "no_internet_text": "অনুগ্রহ করে, আপনার ওয়াইফাই বা মোবাইল ডেটা চালু করুন",
    "error_text": "কিছু ভুল হয়েছে। পরে আবার চেষ্টা করুন"
  };
  static const Map<String, dynamic> en = {
    "app_title": "The Morning News",
    "breaking_news_title": "Breaking News",
    "latest_news_title": "Latest News",
    "more_text": "More",
    "show_all_text": "Show all",
    "save_text": "Save",
    "change_language_title": "Change Language",
    "no_internet_text": "Please, turn on your WiFi or mobile data",
    "error_text": "Something went wrong, please try again later"
  };
  static const Map<String, dynamic> ar = {
    "app_title": "أخبار الصباح",
    "breaking_news_title": "أخبار عاجلة",
    "latest_news_title": "أحدث الأخبار",
    "more_text": "أكثر",
    "show_all_text": "عرض الكل",
    "save_text": "حفظ",
    "change_language_title": "تغيير اللغة",
    "no_internet_text": "من فضلك ، قم بتشغيل واي فاي أو بيانات الجوال",
    "error_text": "هناك شئ خاطئ، يرجى المحاولة فى وقت لاحق"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "bn": bn,
    "en": en,
    "ar": ar
  };
}

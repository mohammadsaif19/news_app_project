import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/const/const.dart';
import 'package:news_project/database_access/services/internet_service.dart';
import 'package:news_project/database_access/services/news_services.dart';
import 'package:news_project/pages/explore_news.dart';
import 'package:news_project/pages/news/news_feed.dart';
import 'package:news_project/providers/pagination_provider.dart';
import 'package:provider/provider.dart';

import 'functions/funtions.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Prevent the app from landscape mode
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    EasyLocalization(
      supportedLocales: localiesList,
      path: 'assets/translations',
      saveLocale: true,
      useOnlyLangCode: true,
      fallbackLocale: localiesList.last,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => NewsServices()),
          RepositoryProvider(create: (_) => InternetService()),
        ],
        child: MultiProvider(
          providers: [
            // Used this provider for pagination loading and preventing the state from rebuilding
            ChangeNotifierProvider(create: (_) => PaginationProvider()),
          ],
          child: const MyApp(),
        ),
      ),
      assetLoader: const CodegenLoader(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breaking News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        // Used different font family for different language
        fontFamily: getFontFamily(context),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: ExploreNews.routeName,
      routes: {
        ExploreNews.routeName: (_) => const ExploreNews(),
        NewsFeed.routeName: (_) => const NewsFeed(
              newsList: [],
            ),
      },
    );
  }
}

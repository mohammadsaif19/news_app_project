import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_project/const/const.dart';
import 'package:news_project/functions/funtions.dart';
import 'package:news_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Integration testing started and covered all the most used use-cases",
    (WidgetTester pilot) async {
      // Initializing the app and wait till it's ready for pilot
      app.main();
      await pilot.pump();
      await pilot.pumpAndSettle(const Duration(seconds: 3));

      // Finding the breaking news listview and tap on one of them
      final breakingNewsListView = find.byKey(BREAKING_NEWS_LISTVIEW_KEY).first;
      await pilot.tap(breakingNewsListView);
      await pilot.pumpAndSettle();

      // This is a artificial delay to see the what's happening
      // If we don't use it then it will very fast and hard to notice
      await delayTill(2);

      // Finding the back button and going back to home page
      final backButton = find.byKey(BACK_BUTTON_FROM_NEWS_KEY);
      await pilot.tap(backButton);
      await pilot.pumpAndSettle();
      await delayTill(2);

      // Tap on the show all button to see the all news feed
      final showAllLatestNewsButton = find.byKey(SHOW_MORE_BUTTON_KEY).first;
      expect(showAllLatestNewsButton, findsOneWidget);
      await pilot.tap(showAllLatestNewsButton);
      await pilot.pumpAndSettle();

      await delayTill(2);

      // Find and tap on one of the news tile
      final latestNewsTile = find.byKey(LATEST_NEWS_LISTVIEW_KEY).first;
      await pilot.tap(latestNewsTile);
      await pilot.pumpAndSettle();

      await delayTill(2);

      // Tap on the favorite button
      final favoriteIconButton = find.byKey(FAVORITE_KEY);
      expect(favoriteIconButton, findsOneWidget);

      await pilot.tap(favoriteIconButton);
      await pilot.pumpAndSettle();

      await delayTill(2);

      // Tap on the un-favorite button
      await pilot.tap(favoriteIconButton);
      await pilot.pumpAndSettle();

      // Going back to the previous page
      await pilot.tap(backButton);
      await pilot.pumpAndSettle();

      await delayTill(2);

      // Going back to the home page
      final backFromNewsFeedButton = find.byType(IconButton);
      await pilot.tap(backFromNewsFeedButton);
      await pilot.pumpAndSettle();

      await delayTill(2);

      // Find and tap on the change language button
      final changeLanguageButton = find.byKey(CHANGE_LANGUAGES_KEY);
      expect(changeLanguageButton, findsOneWidget);

      await pilot.tap(changeLanguageButton);
      await pilot.pumpAndSettle();

      // Find the Arabic language and tap on it
      final languagesTiles = find.text(localiesCountryNames[1]);
      expect(languagesTiles, findsWidgets);
      await pilot.tap(languagesTiles);
      await pilot.pumpAndSettle();

      await delayTill(2);

      // Save the Arabic language as app language
      final saveLanguageButton = find.byType(MaterialButton);
      expect(saveLanguageButton, findsOneWidget);
      await pilot.tap(saveLanguageButton);
      await pilot.pumpAndSettle();

      // The magic show is end here
      await delayTill(2);
    },
  );
}

//Please run this following cmd to run the integration test
// flutter drive \
//   --driver=test_pilot/pilot.dart \
//   --target=test/integration_test.dart

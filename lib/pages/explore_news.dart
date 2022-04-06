import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/database_access/problem_domains/news.dart';
import 'package:news_project/functions/funtions.dart';
import 'package:news_project/generated/locale_keys.g.dart';
import 'package:news_project/pages/news/news_feed.dart';

import '../bloc/news_bloc.dart';
import '../const/colors.dart';
import '../const/const.dart';
import '../const/styles.dart';
import '../database_access/services/internet_service.dart';
import '../database_access/services/news_services.dart';
import '../widget/widgets.dart';
import 'news/news_details.dart';

class ExploreNews extends StatefulWidget {
  static const routeName = '/ExploreNews';
  const ExploreNews({Key? key}) : super(key: key);

  @override
  State<ExploreNews> createState() => _ExploreNewsState();
}

class _ExploreNewsState extends State<ExploreNews> {
  late double _width, _height;
  late Locale _currentLocal;

  List<News> newsList = [];
  List<News> breakingNewsList = [];

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    _width = _screenSize.width;
    _height = _screenSize.height;

    return BlocProvider(
      create: (_) => NewsBloc(
        RepositoryProvider.of<NewsServices>(context),
        RepositoryProvider.of<InternetService>(context),
      )..add(NewsFetchEvent()),
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: ColorPalette.backgroundColor,
          elevation: 0,
          title: Text(
            LocaleKeys.app_title.tr(),
            style: titleTextStyle(),
          ),
          actions: [
            IconButton(
              key: CHANGE_LANGUAGES_KEY,
              icon: Icon(
                Icons.translate,
                size: 30,
                color: ColorPalette.iconColor,
              ),
              onPressed: () async => _showChangeLanguagesAlertDialog(),
            ),
            horizontalSpace(10),
          ],
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (_, state) {
            if (state is NewsLoadingState) {
              // Showing the loading while fetching news from Api
              return loadingWidget();
            } else if (state is NoInternetAccessState) {
              // This state will show the no internet alert
              return noInternetAndErrorWidget(
                  _width, LocaleKeys.no_internet_text.tr());
            } else if (state is NewsFetchedState) {
              // If everything is goes well then showing the explore page with all features
              storeNewsToList(state);
              return _getExplorePageWidget();
            } else {
              // This state will show when something went wrong
              return noInternetAndErrorWidget(
                  _width, LocaleKeys.error_text.tr());
            }
          },
        ),
      ),
    );
  }

  Widget _getExplorePageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(20),
        // Following widget represent the title and more button widget
        _getBreakingNewsTitleWidget(),
        // This widget will render a list of news for the breaking news
        _getBreakingNewsWidget(),
        verticalSpace(20),
        // Following widget will show the title and the show all button widget for latest news
        _getNewsFeedTitleWidget(),
        verticalSpace(15),
        // Next widget will represent the list of latest news tiles
        _getNewsFeedWidget(),
      ],
    );
  }

  // Following widget represent the title and show all widget
  Widget _getBreakingNewsTitleWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.breaking_news_title.tr(),
            style: titleTextStyle().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          showAllTextButtonWidget(
            title: LocaleKeys.more_text.tr(),
            isForDetailsPage: false,
            onTapAction: () {
              pushToWithAnimation(
                  context,
                  NewsFeed(
                    newsList: newsList,
                  ));
            },
          ),
        ],
      ),
    );
  }

  // Following widget will render a list of news for the breaking news
  Widget _getBreakingNewsWidget() {
    return Container(
      width: _width,
      height: _height * 0.25,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: breakingNewsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          News _news = breakingNewsList[index];
          return _breakingNewsInfoWidget(_news);
        },
      ),
    );
  }

  // Following widget represent the breaking news information widget
  Widget _breakingNewsInfoWidget(News news) {
    return GestureDetector(
      key: BREAKING_NEWS_LISTVIEW_KEY,
      onTap: () => pushToWithAnimation(context, NewsDetailsPage(news: news)),
      child: Container(
        width: _width * 0.80,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                height: 1.35,
                fontStyle: FontStyle.italic,
                color: ColorPalette.backgroundColor,
              ),
            ),
            verticalSpace(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    Icons.edit,
                    color: ColorPalette.backgroundColor,
                    size: 20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: ColorPalette.backgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                horizontalSpace(5),
                SizedBox(
                  width: _width * 0.5,
                  child: Text(
                    news.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0,
                      color: ColorPalette.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: CachedNetworkImageProvider(news.urlToImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                ColorPalette.textColor.withOpacity(.3), BlendMode.multiply),
          ),
        ),
      ),
    );
  }

  // Following widget will show the news feed title widget
  Widget _getNewsFeedTitleWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.latest_news_title.tr(),
            style: titleTextStyle().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          showAllTextButtonWidget(
            title: LocaleKeys.show_all_text.tr(),
            isForDetailsPage: false,
            onTapAction: () {
              pushToWithAnimation(
                  context,
                  NewsFeed(
                    newsList: newsList,
                  ));
            },
          ),
        ],
      ),
    );
  }

  // Following widget will represent the list of latest news
  Widget _getNewsFeedWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          News news = newsList[index];
          return getNewsFeedInfoWidget(
              width: _width, context: context, news: news);
        },
      ),
    );
  }

  // Next funtions will return a alert dialog for change the app language
  Future _showChangeLanguagesAlertDialog() async {
    return await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: _width * 0.8,
              height: 310,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _width,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.change_language_title.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: 0,
                            color: ColorPalette.textColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => pop(context),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.cancel_outlined,
                            size: 25,
                            color: ColorPalette.iconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(5),
                  Expanded(child: StatefulBuilder(
                    builder: (_, setState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: localiesList
                            .map(
                              (locale) => Container(
                                child: RadioListTile<Locale>(
                                  key: CHANGE_LANGUAGES_LIST_KEY,
                                  title: Text(
                                    localiesCountryNames[
                                        localiesList.indexOf(locale)],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      color: ColorPalette.textColor,
                                    ),
                                  ),
                                  value: locale,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  activeColor: ColorPalette.primaryColor,
                                  groupValue: _currentLocal,
                                  onChanged: (Locale? value) {
                                    setState(() {
                                      _currentLocal = value!;
                                    });
                                  },
                                ),
                                decoration: BoxDecoration(
                                  border: locale != localiesList.last
                                      ? Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]!),
                                        )
                                      : null,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  )),
                  MaterialButton(
                    minWidth: _width,
                    height: 50,
                    child: Text(
                      LocaleKeys.save_text.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 0,
                        color: ColorPalette.backgroundColor,
                      ),
                    ),
                    color: ColorPalette.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      await context.setLocale(_currentLocal);

                      pop(context);
                    },
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: ColorPalette.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        });
  }

// This method will store the news to list from state for easy access
  storeNewsToList(NewsFetchedState state) {
    newsList = state.newsList;
    for (var i = 0; i < 5; i++) {
      if (breakingNewsList.length == 5) break;
      breakingNewsList.add(newsList.reversed.skip(i).first);
    }
  }

// Used this lifecycle to update the current locale to default locale initially
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentLocal = context.locale;
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_project/const/const.dart';

import 'package:news_project/database_access/problem_domains/news.dart';
import 'package:news_project/functions/funtions.dart';
import 'package:news_project/providers/pagination_provider.dart';
import 'package:provider/provider.dart';

import '../../const/colors.dart';
import '../../const/styles.dart';
import '../../generated/locale_keys.g.dart';
import '../../widget/widgets.dart';

class NewsFeed extends StatefulWidget {
  static const routeName = '/NewsFeed';
  final List<News> newsList;
  const NewsFeed({
    Key? key,
    required this.newsList,
  }) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  late double _width, _height;
  ScrollController _newsController = ScrollController();
  int _currentNewsLimit = 10;
  @override
  void initState() {
    super.initState();
    _newsController = ScrollController()..addListener(_newsScrollListenr);
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    _width = _screenSize.width;
    _height = _screenSize.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.backgroundColor,
          elevation: 0,
          title: Text(
            LocaleKeys.latest_news_title.tr(),
            style: titleTextStyle().copyWith(fontSize: 22),
          ),
          leading: IconButton(
            onPressed: () => pop(context),
            icon: Icon(
              Icons.adaptive.arrow_back_sharp,
              color: ColorPalette.iconColor,
            ),
          ),
        ),
        body: Stack(
          children: [
            // The following widget will show the news feed
            _getNewsFeedListWidget(),
            // This widget will show the loading for pagination when needed
            paginationLoadingWidget(width: _width, height: _height),
          ],
        ));
  }

  // The following widget will show the news feed list
  Widget _getNewsFeedListWidget() {
    return SizedBox(
      width: _width,
      height: _height,
      child: Scrollbar(
        controller: _newsController,
        child: ListView.builder(
          key: LATEST_NEWS_LISTVIEW_KEY,
          itemCount: _currentNewsLimit,
          padding: EdgeInsets.zero,
          controller: _newsController,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            News news = widget.newsList[index];
            return getNewsFeedInfoWidget(
                width: _width, context: context, news: news);
          },
        ),
      ),
    );
  }

// Following method will responsible to handle the pagination
  _newsScrollListenr() async {
    if (_newsController.position.pixels + 5 >=
            _newsController.position.maxScrollExtent &&
        _currentNewsLimit != widget.newsList.length) {
      if (_currentNewsLimit < widget.newsList.length) {
        context.read<PaginationProvider>().updatePaginationLoading(true);
        _currentNewsLimit = (_currentNewsLimit + 10) < widget.newsList.length
            ? _currentNewsLimit + 10
            : widget.newsList.length;
        setState(() {});

        await Future.delayed(const Duration(milliseconds: 500));
        context.read<PaginationProvider>().updatePaginationLoading(false);
      }
    }
  }
}

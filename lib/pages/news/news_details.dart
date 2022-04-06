import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_project/const/const.dart';
import 'package:news_project/database_access/problem_domains/news.dart';

import '../../const/colors.dart';
import '../../functions/funtions.dart';
import '../../widget/widgets.dart';

class NewsDetailsPage extends StatefulWidget {
  final News news;
  static const routeName = '/NewsDetailsPage';
  const NewsDetailsPage({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  late double _width, _height;
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    _width = _screenSize.width;
    _height = _screenSize.height;
    return Scaffold(
      body: Stack(
        children: [
          // Following widget used for show the image, title, and author of the news
          _breakingNewsInfoWidget(),
          // Next widget will represent the news info
          _getTheNewsInfoWidget(),
        ],
      ),
    );
  }

  // Following widget used for show the image, title, and author of the news
  Widget _breakingNewsInfoWidget() {
    return Hero(
      tag: widget.news.title,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        return SingleChildScrollView(
          child: fromHeroContext.widget,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: _width,
          height: _height * 0.44,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      key: BACK_BUTTON_FROM_NEWS_KEY,
                      padding: EdgeInsets.zero,
                      onPressed: () => pop(context),
                      icon: Icon(
                        Icons.adaptive.arrow_back_sharp,
                        size: 30,
                        color: ColorPalette.backgroundColor,
                      ),
                    ),
                    IconButton(
                      key: FAVORITE_KEY,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 30,
                        color: ColorPalette.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.news.title,
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
                      Text(
                        widget.news.author,
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0,
                          color: ColorPalette.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.news.urlToImage),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  ColorPalette.textColor.withOpacity(.3), BlendMode.multiply),
            ),
          ),
        ),
      ),
    );
  }

  // Following widget will represent the news info
  Widget _getTheNewsInfoWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: _width,
        height: _height * 0.58,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: ColorPalette.subTextColor,
                      size: 20,
                    ),
                    horizontalSpace(5),
                    Text(
                      "${getDate(widget.news)}  ·  ${getTime(widget.news)}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: ColorPalette.subTextColor,
                      ),
                    ),
                  ],
                ),
                showAllTextButtonWidget(
                  title: widget.news.source.name,
                  isForDetailsPage: true,
                  onTapAction: () {},
                ),
              ],
            ),
            verticalSpace(10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.news.content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: ColorPalette.subTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: ColorPalette.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

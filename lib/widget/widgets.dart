import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/const/const.dart';
import 'package:news_project/database_access/problem_domains/news.dart';
import 'package:news_project/functions/funtions.dart';
import 'package:news_project/pages/news/news_details.dart';
import 'package:news_project/providers/pagination_provider.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';

SizedBox verticalSpace(double size) => SizedBox(height: size);
SizedBox horizontalSpace(double size) => SizedBox(width: size);

// This is most used widget for more and show all button and category title.
Widget showAllTextButtonWidget({
  required String title,
  required Function() onTapAction,
  required bool isForDetailsPage,
}) {
  return GestureDetector(
    onTap: onTapAction,
    key: SHOW_MORE_BUTTON_KEY,
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: isForDetailsPage ? 15 : 10, vertical: 3),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontSize: isForDetailsPage ? 12 : 10,
          fontWeight: FontWeight.w600,
          color: ColorPalette.textColor,
        ),
      ),
      decoration: BoxDecoration(
        color: ColorPalette.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(isForDetailsPage ? 8 : 15),
      ),
    ),
  );
}

// This widget will represent the news info tile for explore and news feed page
Widget getNewsFeedInfoWidget({
  required double width,
  required BuildContext context,
  required News news,
}) {
  return GestureDetector(
    key: LATEST_NEWS_LISTVIEW_KEY,
    onTap: () => pushTo(context, NewsDetailsPage(news: news)),
    child: Container(
      width: width,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: news.title,
            flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
            ) {
              return SingleChildScrollView(
                child: toHeroContext.widget,
              );
            },
            child: Container(
              width: width * 0.3,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => loadingWidget(),
                  errorWidget: (_, __, ___) =>
                      Image.asset("assets/images/ksa.jpeg"),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 1.3,
                      color: ColorPalette.textColor,
                    ),
                  ),
                ),
                Text(
                  "${getDate(news)}  ·  ${getTime(news)}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!),
        ),
      ),
    ),
  );
}

// Following widget will show the laoding for specific platform
Widget loadingWidget() {
  return Center(
    key: LOADING_KEY,
    child: Platform.isIOS
        ? const CupertinoActivityIndicator(
            radius: 18,
          )
        : CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorPalette.primaryColor)),
  );
}

// Following widget will be visible while paginating

Widget paginationLoadingWidget({
  required double width,
  required double height,
}) {
  {
    return Consumer<PaginationProvider>(
      builder: (_, paginationProvider, __) =>
          paginationProvider.isPaginationLoading
              ? Center(
                  child: Container(
                    width: 65,
                    height: 65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300]!,
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: const Offset(0, 0))
                        ]),
                    child: loadingWidget(),
                  ),
                )
              : Container(),
    );
  }
}

// This is the no internet and error widget
Widget noInternetAndErrorWidget(double width, String title) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/nointernet.png',
          width: width * 0.6,
        ),
        verticalSpace(30),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorPalette.textColor,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}

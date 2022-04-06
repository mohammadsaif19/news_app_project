import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:news_project/database_access/services/internet_service.dart';
import 'package:news_project/database_access/services/news_services.dart';

import '../database_access/problem_domains/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsServices _newsServices;
  final InternetService _internetService;
  NewsBloc(this._newsServices, this._internetService)
      : super(NewsLoadingState()) {
    _internetService.connectivityStream.stream
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        add(NoInternetAccessEvent());
      } else {
        add(NewsFetchEvent());
      }
    });
    on<NewsFetchEvent>((event, emit) async {
      emit(NewsLoadingState());
      List<News> _newsList = await _newsServices.fetchNews();
      emit(NewsFetchedState(_newsList));
    });

    on<NoInternetAccessEvent>((event, emit) async {
      emit(NoInternetAccessState());
    });
  }
}

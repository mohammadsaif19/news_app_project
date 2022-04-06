part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsFetchEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class NoInternetAccessEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

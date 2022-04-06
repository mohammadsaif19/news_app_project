part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsFetchedState extends NewsState {
  final List<News> newsList;

  const NewsFetchedState(this.newsList);
  @override
  List<Object> get props => newsList;
}

class NoInternetAccessState extends NewsState {
  @override
  List<Object> get props => [];
}

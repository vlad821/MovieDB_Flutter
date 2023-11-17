part of 'search_tv_bloc.dart';

//@immutable
abstract class SearchTvState {}

class SearchTvInitial extends SearchTvState {}

class SearchTvSucess extends SearchTvState {
  final List popular;
  final List trending;
  final List upcoming;
  final List rated;
  SearchTvSucess({
    required this.popular,
    required this.trending,
    required this.upcoming,
    required this.rated,
  });
}

class SearchTvError extends SearchTvState {}

class SearchTvLoading extends SearchTvState {}

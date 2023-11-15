part of 'search_tv_shows_cubit.dart';

enum TvStatus { loading, success, error, initial, notFound }

class SearchTvShowsState extends Equatable {
  final TvStatus status;
  final String error;
  final List movies;
  SearchTvShowsState({required this.status, required this.movies, required this.error});

  factory SearchTvShowsState.initial() {
    return SearchTvShowsState(
      movies: [],
      status: TvStatus.initial,
      error: '',
    );
  }
  @override
  List<Object> get props => [status, error, movies];
  @override
  bool get stringify => true;

  SearchTvShowsState copyWith({
    required TvStatus status,
    required String error,
    required List movies,
  }) {
    return SearchTvShowsState(
      status: status,
      error: error,
      movies: movies,
    );
  }
}

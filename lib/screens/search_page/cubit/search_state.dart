part of 'search_cubit.dart';

enum MovieStatus { loading, success, error, initial, notFound }

class SearchMovieState extends Equatable {
  final MovieStatus status;
  final String error;
  final List movies;
  SearchMovieState({required this.status, required this.movies, required this.error});

  factory SearchMovieState.initial() {
    return SearchMovieState(
      movies: [],
      status: MovieStatus.initial,
      error: '',
    );
  }
  @override
  List<Object> get props => [status, error, movies];
  @override
  bool get stringify => true;

  SearchMovieState copyWith({
    required MovieStatus status,
    required String error,
    required List movies,
  }) {
    return SearchMovieState(
      status: status,
      error: error,
      movies: movies,
    );
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'search_tv_shows_state.dart';

class SearchTvShowsCubit extends Cubit<SearchTvShowsState> {
  SearchTvShowsCubit() : super(SearchTvShowsState.initial());
  void onSubmitted(String value) async {
    emit(state.copyWith(status: TvStatus.loading, error: 'k', movies: []));
    try {
      List movies = [];

      int lessthen;
      var comicCreaters = Uri.parse(
          "https://api.themoviedb.org/3/search/tv?api_key=84ebd14770d7675041b532f1d88ce324&query=$value&page=1&include_adult=true");

      final response = await http.get(comicCreaters);
      final data = json.decode(response.body);
      if (data['total_pages'] > 10) {
        lessthen = 10;
        print(lessthen);
      } else {
        lessthen = data['total_pages'];
        print(lessthen);
      }
      print(lessthen);

      for (int i = 1; i <= lessthen; i++) {
        String index = i.toString();
        var moviesurl = Uri.parse(
            "https://api.themoviedb.org/3/search/tv?api_key=84ebd14770d7675041b532f1d88ce324&query=$value&page=$index&include_adult=true");

        final response1 = await http.get(moviesurl);
        final data1 = json.decode(response1.body);
        final allmovies = data1['results'];
        // print(allmovies);
        movies.addAll(allmovies);
      }
      if (movies.isEmpty) {
        emit(state.copyWith(
          status: TvStatus.notFound, error: 'j', movies: [],
        ));
      } else {
        emit(state.copyWith(status: TvStatus.success, movies: movies, error: ''));
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: TvStatus.error, error: '', movies: []));
    }
  }
}

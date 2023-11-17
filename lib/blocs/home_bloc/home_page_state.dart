part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class FetchHomeSucess extends HomePageState {
  final List trending;
  final List marvel;
  final List company;
  final List tv;
  final List category1;
  final List category2;
  final List category3;
  final List category4;
  final List category5;
  final List category6;
  final List category7;
  final List tvcategory1;
  final List tvcategory2;
   final List tvcategory3;
  final List tvcategory4;
  FetchHomeSucess({
    required this.trending,
    required this.marvel,
    required this.company,
    required this.tv,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
    required this.category6,
    required this.category7,
    required this.tvcategory1,
    required this.tvcategory2,
    required this.tvcategory3,
    required this.tvcategory4,
  });
}

class FetchHomeError extends HomePageState {}

class FetchHomeLoading extends HomePageState {}

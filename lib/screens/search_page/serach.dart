import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:movies/blocs/home_bloc/home_page_bloc.dart';
import 'package:movies/blocs/search_bloc/search_movies_bloc.dart';
import 'package:movies/screens/bottom_nav_bar.dart';
import 'package:movies/screens/search_page/cubit/search_cubit.dart';
import 'package:movies/screens/search_page/search_results.dart';
//import 'package:movies/screens/widgets/company_carasouls.dart';
import 'package:movies/screens/widgets/movies_carausols.dart';
//import 'package:movies/screens/widgets/treanding.dart';
//import 'package:movies/screens/widgets/trending_tv.dart';
//import 'package:movies/screens/widgets/tv_carausols.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        IconButton(
          onPressed:signUserOut,
           icon:Icon (Icons.logout)
        )
      ],
        centerTitle: true,
        title: Text(
          "TMDB",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 123, 5, 5),
              Color.fromARGB(255, 60, 2, 2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add your desired padding here
         
      child: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
          if (state is SearchMoviesLoading) {
            return Center(
              child: SpinKitSquareCircle(
                color: Colors.orangeAccent,
                size: 50.0,
              ),
            );
          } else if (state is SearchMoviesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Something wents worng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Have another try?",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: Colors.orangeAccent,
    elevation: 0, // You can adjust the elevation here if needed.
  ),
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => SearchMoviesBloc()..add(SearchLoadContent()),
          child: SearchPage(),
        ),
      ),
    );
  },
  child: Text("Try again"),
)

                ],
              ),
            );
          } else if (state is SearchMoviesSucess) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverToBoxAdapter(
                    child: TextField(
                      decoration: InputDecoration(
                         iconColor: Colors.white,
                            fillColor: Colors.white,
                            filled: true,
                          hintText: "Search Movies..",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 5,
                                style: BorderStyle.solid,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15))),
                      onSubmitted: (value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => SearchMoviesCubit(),
                                  child: Initalmovies(value),
                                )));
                      },
                    ),
                  ),
                ),
                header("This week's Trending Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.trending, 
                )
                ),
                header("Top rated Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.rated,
                )),
                header("Popular Movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.popular,
                )),
                header("Upcoming movies", () {}),
                SliverToBoxAdapter(
                    child: MoviesContainerSimilar(
                  listPaths: state.upcoming,
                )),
              ],
            );
          } else {
            return Scaffold();
          }
        },
      ),
        ),
      )
    );
  }

  SliverAppBar header(String info, Function ontap) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Text(info,
          style: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}

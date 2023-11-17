import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/blocs/bloc/search_tv_bloc.dart';
import 'package:movies/screens/bottom_nav_bar.dart';
import 'package:movies/screens/search_tv/cubit/search_tv_shows_cubit.dart';
import 'package:movies/screens/search_tv/search_results.dart';
import 'package:movies/screens/widgets/tv_carausols.dart';

class SearchPageTv extends StatelessWidget {
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
          child: BlocBuilder<SearchTvBloc, SearchTvState>(
            builder: (context, state) {
              if (state is SearchTvLoading) {
                return Center(
                  child: SpinKitSquareCircle(
                    color: Color.fromARGB(255, 255, 231, 10),
                    size: 50.0,
                  ),
                );
              } else if (state is SearchTvError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Something wents wrong",
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
          onPressed: () {
            Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => SearchTvBloc()..add(SearchTvLoadContent()),
              child: SearchPageTv(),
            ),
          ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.orangeAccent,
          ),
          child: Text("Try again"),
              )
              
                    ],
                  ),
                );
              } else if (state is SearchTvSucess) {
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
//hoverColor: Colors.pink,
                              hintText: "Search Tv Shows..",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 4,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 5,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  borderRadius: BorderRadius.circular(15))),
                          onSubmitted: (value) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => SearchTvShowsCubit(),
                                      child: InitalTv(value),
                                    )));
                          },
                        ),
                      ),
                    ),
                    header("This week's Trending shows", () {}),
                    SliverToBoxAdapter(
                        child: TvContainerSimilar(
                      listPaths: state.trending, key: GlobalKey(),
                    )),
                    header("Top rated shows", () {}),
                    SliverToBoxAdapter(
                        child: TvContainerSimilar(
                      listPaths: state.rated, key: GlobalKey(),
                    )),
                    header("Popular shows", () {}),
                    SliverToBoxAdapter(
                        child: TvContainerSimilar(
                      listPaths: state.popular, key: GlobalKey(),
                    )),
                  ],
                );
              } else {
                return Scaffold();
              }
            },
          ),
        ),
      ),
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

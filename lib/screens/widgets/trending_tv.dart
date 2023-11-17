import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/tv_bloc/tv_info_bloc.dart';
import 'package:movies/screens/tv_info.dart';

class TrendingContainertv extends StatelessWidget {
  final List listPaths;

  const TrendingContainertv({ Key ?key, required this.listPaths}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 123, 5, 5), Color.fromARGB(255, 60, 2, 2)], // Change colors as needed
          ),
        ),
      height: 400,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: listPaths.length,
          scrollDirection: Axis.horizontal,
          // store this controller in a State to save the carousel scroll position
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        TvInfoBloc()..add(TvLoadContent(listPaths[i]['id'])),
                    child: TvInfo(),
                  ),
                ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 225, 22, 22),
                          blurRadius: .7,
                        ),
                      ],
                      color: Color.fromARGB(255, 64, 255, 6),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(8),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 400,
                              imageUrl:
                                  "https://image.tmdb.org/t/p/w500${listPaths[i]['backdrop_path']}",
                              placeholder: (context, url) => Container(
                                  color: Colors.grey,
                                  height: 400,
                                  child: Center(
                                      child: CupertinoActivityIndicator())),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                listPaths[i]['name'],
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          listPaths[i]['overview'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/bloc/search_tv_bloc.dart';
import 'package:movies/chat/pages/homee.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:movies/blocs/search_bloc/search_movies_bloc.dart';
import 'package:movies/screens/search_page/serach.dart';
import 'package:movies/screens/search_tv/search.dart';

class BottomNavView extends StatefulWidget {
  @override
  _BottomNavViewState createState() => _BottomNavViewState();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _BottomNavViewState extends State<BottomNavView> {
  
  // int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
   Homme(),
    BlocProvider(
      create: (context) => SearchMoviesBloc()..add(SearchLoadContent()),
      child: SearchPage(),
    ),
    BlocProvider(
      create: (context) => SearchTvBloc()..add(SearchTvLoadContent()),
      child: SearchPageTv(),
    ),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
     PersistentBottomNavBarItem(
   // Use 'screen' or the appropriate parameter
  inactiveColorPrimary: Colors.grey,
  icon: Icon(Icons.chat),
  activeColorPrimary: Color.fromARGB(255, 160, 18, 18),
  title: ("Chat"),
),


      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.search),
        activeColorPrimary: Color.fromARGB(255, 160, 18, 18),
        title: ("Movies"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.tv),
        activeColorPrimary: Color.fromARGB(255, 160, 18, 18),
        title: ("Tv Shows"),
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.local_activity),
      //   inactiveColorPrimary: Colors.grey,
      //   activeColorPrimary: Colors.red,
      //   title: ("ProfileScreen"),
      // ),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     body: Center(
      child: PersistentTabView(
        this.context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style9,
      ),
     )
    );
    
  }
}

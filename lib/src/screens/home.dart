import 'package:flutter/material.dart';
import '../blocs/navigation_provider.dart';
import '../styles.dart';
import 'landin_screen.dart';
import 'search.dart';
import 'profile.dart';
import 'turf_detail.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    final navBloc = NavigationProvider.of(context);
    List<Widget> widgets = [
      LandingPage(),
      SearchScreen(),
      TurfDetail(),
      ProfileScreen(),
    ];

    List<Text> titles = [
      Text("Search"),
      Text("Alerts"),
      Text("Profile"),
    ];

    return StreamBuilder(
      stream: navBloc.currentIndex,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: EmptyAppBar(),
          backgroundColor: TurfColors.bgColor,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (integer) {
              navBloc.changeIndex(integer);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: snapshot.hasData ? snapshot.data : 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                title: Text("Search"),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                title: Text('Alerts'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                title: Text(
                  'Profile',
                ),
              ),
            ],
          ),
          body: Center(
            child: widgets[snapshot.hasData ? snapshot.data : 0],
          ),
        );
      },
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0.0, 0.0);
}

import 'package:flutter/material.dart';
import '../styles.dart';
import 'landin_screen.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext coontext) {
    return Scaffold(
      backgroundColor: TurfColors.bgColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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
        child: LandingPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext coontext) {
    return Scaffold(
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
              Icons.crop_free,
            ),
            title: Text('Scan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.remove_red_eye,
            ),
            title: Text(
              'Prediction',
            ),
          ),
        ],
      ),
      body: Center(
        child: Text("Hello Turf"),
      ),
    );
  }
}

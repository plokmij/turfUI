import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'styles.dart';
import 'blocs/navigation_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return NavigationProvider(
      child: MaterialApp(
        home: Home(),
        theme: ThemeData(
          primaryColor: TurfColors.red,
          backgroundColor: TurfColors.bgColor,
        ),
      ),
    );
  }
}

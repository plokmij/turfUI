import 'package:flutter/material.dart';
import 'navigation_bloc.dart';
export 'navigation_bloc.dart';

class NavigationProvider extends InheritedWidget {
  final bloc = NavigationBloc();

  NavigationProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static NavigationBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NavigationProvider)
            as NavigationProvider)
        .bloc;
  }
}
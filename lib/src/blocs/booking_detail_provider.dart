import 'booking_detail.dart';
import 'package:flutter/material.dart';
export 'booking_detail.dart';

class DateTimeProvider extends InheritedWidget {
  final dateTimeBloc = DateTimeBloc();

  DateTimeProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static DateTimeBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DateTimeProvider) as DateTimeProvider).dateTimeBloc;
  }
}
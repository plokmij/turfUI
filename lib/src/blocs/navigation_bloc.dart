import 'package:rxdart/rxdart.dart';

class NavigationBloc extends Object{
  final _currentIndex = BehaviorSubject<int>();

  Observable<int> get currentIndex => _currentIndex.stream;

  Function(int) get changeIndex => _currentIndex.sink.add;

  dispose(){
    _currentIndex.close();
  }
}
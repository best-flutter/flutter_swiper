import 'package:flutter/material.dart';

class SwiperController extends ChangeNotifier {
  int _index;
  bool _animation;

  bool get animation => _animation;
  int get index => _index;
  void set index(int index) => _index = index;

  SwiperController(int index) : _index = index;

  void move(int index, {bool animation: true}) {
    _index = index;
    _animation = animation;
    notifyListeners();
  }

  void next({bool animation: true}) {
    ++_index;
    _animation = animation;
    notifyListeners();
  }

  void previous({bool animation: true}) {
    --_index;
    _animation = animation;
    notifyListeners();
  }
}

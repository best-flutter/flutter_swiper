import 'package:flutter/material.dart';

enum SwiperControllerEvent { INDEX, AUTOPLAY }

class SwiperController extends ChangeNotifier {
  int _index;
  bool _animation;

  bool _autoplay;
  SwiperControllerEvent _event;

  bool get animation => _animation;
  int get index => _index;
  void set index(int index) => _index = index;

  void set autoplay(bool autoplay) => _autoplay = autoplay;

  bool get autoplay => _autoplay;

  SwiperControllerEvent get event => _event;

  SwiperController(int index) : _index = index;

  /**
   * move to index
   */
  void move(int index, {bool animation: true}) {
    _event = SwiperControllerEvent.INDEX;
    _index = index;
    _animation = animation;
    notifyListeners();
  }

  /**
   * goto next index
   */
  void next({bool animation: true}) {
    _event = SwiperControllerEvent.INDEX;
    ++_index;
    _animation = animation;
    notifyListeners();
  }

  /**
   * goto previous index
   */
  void previous({bool animation: true}) {
    _event = SwiperControllerEvent.INDEX;
    --_index;
    _animation = animation;
    notifyListeners();
  }

  void startAutoplay() {
    _event = SwiperControllerEvent.AUTOPLAY;
    _autoplay = true;
    notifyListeners();
  }

  void stopAutoplay() {
    _event = SwiperControllerEvent.AUTOPLAY;
    _autoplay = false;
    notifyListeners();
  }
}

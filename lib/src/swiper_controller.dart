import 'package:flutter/material.dart';

enum SwiperControllerEvent {
  PREV_INDEX,
  NEXT_INDEX,
  MOVE_INDEX,
  START_AUTOPLAY,
  STOP_AUTOPLAY
}

class SwiperController extends ChangeNotifier {
  int index;
  bool animation;
  bool autoplay;
  SwiperControllerEvent _event;

  SwiperControllerEvent get event => _event;

  SwiperController();

  ///move to index
  void move(int index, {bool animation: true}) {
    _event = SwiperControllerEvent.MOVE_INDEX;
    this.index = index;
    this.animation = animation;
    notifyListeners();
  }

  /// goto next index
  void next({bool animation: true}) {
    _event = SwiperControllerEvent.NEXT_INDEX;
    this.animation = animation;
    notifyListeners();
  }

  /// goto previous index
  void previous({bool animation: true}) {
    _event = SwiperControllerEvent.PREV_INDEX;
    this.animation = animation;
    notifyListeners();
  }

  void startAutoplay() {
    _event = SwiperControllerEvent.START_AUTOPLAY;
    this.autoplay = true;
    notifyListeners();
  }

  void stopAutoplay() {
    _event = SwiperControllerEvent.STOP_AUTOPLAY;
    this.autoplay = false;
    notifyListeners();
  }
}

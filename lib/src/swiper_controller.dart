import 'package:flutter/material.dart';

enum SwiperControllerEvent { INDEX, AUTOPLAY }

class SwiperController extends ChangeNotifier {
  int index;
  bool animation;

  bool autoplay;

  SwiperControllerEvent _event;



  SwiperControllerEvent get event => _event;

  SwiperController(this.index);

  ///move to index
  void move(int index, {bool animation: true}) {
    _event = SwiperControllerEvent.INDEX;
    index = index;
    animation = animation;
    notifyListeners();
  }

  /// goto next index
  void next({bool animation: true}) {
    _event = SwiperControllerEvent.INDEX;
    ++index;
    this.animation = animation;
    notifyListeners();
  }

  /// goto previous index
  void previous({bool animation: true}) {
    _event = SwiperControllerEvent.INDEX;
    --index;
    this.animation = animation;
    notifyListeners();
  }

  void startAutoplay() {
    _event = SwiperControllerEvent.AUTOPLAY;
    autoplay = true;
    notifyListeners();
  }

  void stopAutoplay() {
    _event = SwiperControllerEvent.AUTOPLAY;
    autoplay = false;
    notifyListeners();
  }
}

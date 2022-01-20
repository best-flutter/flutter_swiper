import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class IndexController extends ChangeNotifier {
  static const int NEXT = 1;
  static const int PREVIOUS = -1;
  static const int MOVE = 0;

  Completer _completer;

  int index;
  bool animation;
  int event;

  Future move(int index, {bool animation: true}) {
    this.animation = animation ?? true;
    this.index = index;
    this.event = MOVE;
    _completer = new Completer();
    notifyListeners();
    return _completer.future;
  }

  Future next({bool animation: true}) {
    this.event = NEXT;
    this.animation = animation ?? true;
    _completer = new Completer();
    notifyListeners();
    return _completer.future;
  }

  Future previous({bool animation: true}) {
    this.event = PREVIOUS;
    this.animation = animation ?? true;
    _completer = new Completer();
    notifyListeners();
    return _completer.future;
  }

  void complete() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }
}
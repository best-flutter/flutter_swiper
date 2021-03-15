import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class IndexController extends ChangeNotifier {
  static const int NEXT = 1;
  static const int PREVIOUS = -1;
  static const int MOVE = 0;

  late Completer _completer;

  int? index;
  bool? animation;
  int? event;

  Future move(int index, {bool animation = true}) {
    this.animation = animation;
    this.index = index;
    event = MOVE;
    _completer = Completer();
    notifyListeners();
    return _completer.future;
  }

  Future next({bool animation = true}) {
    event = NEXT;
    this.animation = animation;
    _completer = Completer();
    notifyListeners();
    return _completer.future;
  }

  Future previous({bool animation = true}) {
    event = PREVIOUS;
    this.animation = animation;
    _completer = Completer();
    notifyListeners();
    return _completer.future;
  }

  void complete() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }
}

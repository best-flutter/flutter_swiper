import 'package:transformer_page_view/transformer_page_view.dart';

class SwiperController extends IndexController {
  static const int START_AUTOPLAY = 2;
  static const int STOP_AUTOPLAY = 3;

  int index;
  bool animation;
  bool autoplay;

  SwiperController();

  void startAutoplay() {
    event = SwiperController.START_AUTOPLAY;
    this.autoplay = true;
    notifyListeners();
  }

  void stopAutoplay() {
    event = SwiperController.STOP_AUTOPLAY;
    this.autoplay = false;
    notifyListeners();
  }
}

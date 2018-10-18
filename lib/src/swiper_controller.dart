import 'package:flutter_swiper/src/swiper_plugin.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class SwiperController extends IndexController {
  // Autoplay is started
  static const int START_AUTOPLAY = 2;

  // Autoplay is stopped.
  static const int STOP_AUTOPLAY = 3;

  // Indicate that user is swiping
  static const int SWIPE = 4;

  // Indicate that `Swiper` has changed it's index and is building it's ui ,so that the
  // `SwiperPluginConfig` is available.
  static const int BUILD = 5;

  // Avaliable when `event` == SwiperController.BUILD
  SwiperPluginConfig config;

  // Avaliable when `event` == SwiperController.SWIPE
  double position;

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

import 'swiper_plugin.dart';
import 'transformer_page_view/index_controller.dart';

class SwipeIndexControllerEvent extends IndexControllerEventBase {
  SwipeIndexControllerEvent({
    required this.pos,
    required bool animation,
  }) : super(animation: animation);
  final double pos;
}

class BuildIndexControllerEvent extends IndexControllerEventBase {
  BuildIndexControllerEvent({
    required bool animation,
    required this.config,
  }) : super(animation: animation);
  final SwiperPluginConfig config;
}

class AutoPlaySwiperControllerEvent extends IndexControllerEventBase {
  AutoPlaySwiperControllerEvent({
    required bool animation,
    required this.autoplay,
  }) : super(animation: animation);

  AutoPlaySwiperControllerEvent.start({
    required bool animation,
  }) : this(animation: animation, autoplay: true);
  AutoPlaySwiperControllerEvent.stop({
    required bool animation,
  }) : this(animation: animation, autoplay: false);
  final bool autoplay;
}

class SwiperController extends IndexController {
  void startAutoplay({bool animation = true}) {
    event = AutoPlaySwiperControllerEvent.start(animation: animation);
    notifyListeners();
  }

  void stopAutoplay({bool animation = true}) {
    event = AutoPlaySwiperControllerEvent.stop(animation: animation);
    notifyListeners();
  }
}

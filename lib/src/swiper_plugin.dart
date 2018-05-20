import 'package:flutter/widgets.dart';
import 'package:infinity_page_view/infinity_page_view.dart';
import 'swiper_controller.dart';

/**
 * plugin to display swiper components
 */
abstract class SwiperPlugin<T> {
  const SwiperPlugin();

  T build(SwiperPluginConfig config);
}

class SwiperPluginConfig {
  final int activeIndex;
  final int itemCount;
  final Axis axis;

  final SwiperController controller;

  const SwiperPluginConfig({
    this.activeIndex,
    this.itemCount,
    this.axis,
    this.controller,
  })  : assert(axis != null),
        assert(controller != null);
}

class SwiperPluginView extends StatelessWidget {
  final SwiperPlugin plugin;
  final SwiperPluginConfig config;

  const SwiperPluginView(this.plugin, this.config);

  @override
  Widget build(BuildContext context) {
    return plugin.build(config);
  }
}

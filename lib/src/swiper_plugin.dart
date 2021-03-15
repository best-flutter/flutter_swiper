import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_swiper/src/flutter_page_indicator/flutter_page_indicator.dart';

/// plugin to display swiper components
///
abstract class SwiperPlugin {
  const SwiperPlugin();

  Widget build(BuildContext context, SwiperPluginConfig config);
}

class SwiperPluginConfig {
  final Axis scrollDirection;
  final SwiperController controller;
  final int? activeIndex;
  final int? itemCount;
  final PageIndicatorLayout? indicatorLayout;
  final bool? loop;
  final bool? outer;
  final PageController? pageController;
  final SwiperLayout? layout;

  const SwiperPluginConfig({
    required this.scrollDirection,
    required this.controller,
    this.activeIndex,
    this.itemCount,
    this.indicatorLayout,
    this.outer,
    this.pageController,
    this.layout,
    this.loop,
  });
}

class SwiperPluginView extends StatelessWidget {
  final SwiperPlugin plugin;
  final SwiperPluginConfig config;

  const SwiperPluginView(this.plugin, this.config);

  @override
  Widget build(BuildContext context) {
    return plugin.build(context, config);
  }
}

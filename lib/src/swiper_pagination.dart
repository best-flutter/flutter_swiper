import 'package:flutter/material.dart';
import 'swiper_plugin.dart';

class BubbleSwiperPaginationBuilder extends SwiperPlugin<Widget> {
  final Color highlightColor;
  final Color normalColor;

  /**
   * Size of the bubble
   */
  final double size;

  /**
   * Space between bubbles
   */
  final double space;

  const BubbleSwiperPaginationBuilder(
      {this.highlightColor: Colors.blueAccent,
      this.normalColor: Colors.black12,
      this.size: 10.0,
      this.space: 3.0});

  @override
  Widget build(SwiperPluginConfig config) {
    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      list.add(new Container(
        key: new Key("pagination_${i}"),
        margin: new EdgeInsets.all(space),
        child: new ClipOval(
          child: new Container(
            color: i == activeIndex ? highlightColor : normalColor,
            width: size,
            height: size,
          ),
        ),
      ));
    }

    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}

/**
 *
 */
class SwiperPagination extends SwiperPlugin<Widget> {
  static const SwiperPlugin bubble = const BubbleSwiperPaginationBuilder();

  final AlignmentGeometry alignment;
  final double margin;
  final SwiperPlugin builder;
  final Axis axis;

  SwiperPagination(
      {this.alignment: Alignment.bottomCenter,
      this.margin: 10.0,
      this.axis: Axis.horizontal,
      this.builder: SwiperPagination.bubble});

  Widget build(SwiperPluginConfig config) {
    return new Align(
      key: const Key("swiper_pagination"),
      alignment: alignment,
      child: new Container(
        key: const Key("swiper_pagination_container"),
        margin: new EdgeInsets.all(margin),
        child: this.builder.build(config),
      ),
    );
  }
}

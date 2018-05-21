import 'package:flutter/material.dart';
import 'swiper_plugin.dart';
import 'package:flutter/foundation.dart';

class FractionPaginationBuilder extends SwiperPlugin {
  /**
   * color
   */
  final Color color;

  /**
   * color when active
   */
  final Color activeColor;

  /**
   * font size
   */
  final double fontSize;

  /**
   * font size when active
   */
  final double activeFontSize;

  const FractionPaginationBuilder(
      {this.color: Colors.blueGrey,
      this.fontSize: 20.0,
      this.activeColor: Colors.blueAccent,
      this.activeFontSize: 35.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    if (Axis.vertical == config.scrollDirection) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            "${config.activeIndex+1}",
            style: new TextStyle(color: activeColor, fontSize: activeFontSize),
          ),
          new Text(
            "/",
            style: new TextStyle(color: color, fontSize: fontSize),
          ),
          new Text(
            "${config.itemCount}",
            style: new TextStyle(color: color, fontSize: fontSize),
          )
        ],
      );
    } else {
      return new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            "${config.activeIndex+1}",
            style: new TextStyle(color: activeColor, fontSize: activeFontSize),
          ),
          new Text(
            " / ${config.itemCount}",
            style: new TextStyle(color: color, fontSize: fontSize),
          )
        ],
      );
    }
  }
}

class DotSwiperPaginationBuilder extends SwiperPlugin {
  /**
   * color when current index
   */
  final Color activeColor;

  /**
   *
   */
  final Color color;

  /**
   * Size of the dot when activate
   */
  final double activeSize;

  /**
   * Size of the dot
   */
  final double size;

  /**
   * Space between dots
   */
  final double space;

  const DotSwiperPaginationBuilder(
      {this.activeColor: Colors.blueAccent,
      this.color: Colors.black12,
      this.size: 10.0,
      this.activeSize: 10.0,
      this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> list = [];

    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(new Container(
        key: new Key("pagination_${i}"),
        margin: new EdgeInsets.all(space),
        child: new ClipOval(
          child: new Container(
            color: active ? activeColor : color,
            width: active ? activeSize : size,
            height: active ? activeSize : size,
          ),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return new Row(
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}

typedef Widget SwiperPaginationBuilder(
    BuildContext context, SwiperPluginConfig config);

class SwiperCustomPagination extends SwiperPlugin {
  final SwiperPaginationBuilder builder;

  SwiperCustomPagination({@required this.builder}) : assert(builder != null);

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return builder(context, config);
  }
}

/**
 *
 */
class SwiperPagination extends SwiperPlugin {
  /**
   * dot style pagination
   */
  static const SwiperPlugin dots = const DotSwiperPaginationBuilder();

  /**
   * fraction style pagination
   */
  static const SwiperPlugin fraction = const FractionPaginationBuilder();

  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final SwiperPlugin builder;

  const SwiperPagination(
      {this.alignment: Alignment.bottomCenter,
      this.margin: const EdgeInsets.all(10.0),
      this.builder: SwiperPagination.dots});

  Widget build(BuildContext context, SwiperPluginConfig config) {
    return new Align(
      key: const Key("swiper_pagination"),
      alignment: alignment,
      child: new Container(
        key: const Key("swiper_pagination_container"),
        margin: margin,
        child: this.builder.build(context, config),
      ),
    );
  }
}

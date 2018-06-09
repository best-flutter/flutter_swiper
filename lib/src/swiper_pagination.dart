import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FractionPaginationBuilder extends SwiperPlugin {
  ///color ,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///color when active,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ////font size
  final double fontSize;

  ///font size when active
  final double activeFontSize;

  const FractionPaginationBuilder(
      {this.color,
      this.fontSize: 20.0,
      this.activeColor,
      this.activeFontSize: 35.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;

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

class RectSwiperPaginationBuilder extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return null;
  }
}

class DotSwiperPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double activeSize;

  ///Size of the dot
  final double size;

  /// Space between dots
  final double space;

  final Key key;

  const DotSwiperPaginationBuilder(
      {this.activeColor,
      this.color,
      this.key,
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

    ThemeData themeData = Theme.of(context);

    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(new Container(
        key: new Key("pagination_$i"),
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
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return new Row(
        key: key,
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

class SwiperPagination extends SwiperPlugin {
  /// dot style pagination
  static const SwiperPlugin dots = const DotSwiperPaginationBuilder();

  /// fraction style pagination
  static const SwiperPlugin fraction = const FractionPaginationBuilder();

  /// Alignment.bottomCenter by default when scrollDirection== Axis.horizontal
  /// Alignment.centerRight by default when scrollDirection== Axis.vertical
  final AlignmentGeometry alignment;

  /// Distance between pagination and the container
  final EdgeInsetsGeometry margin;

  /// Build the widet
  final SwiperPlugin builder;



  final Key key;

  const SwiperPagination(
      {this.alignment,
      this.key,
      this.margin: const EdgeInsets.all(10.0),
      this.builder: SwiperPagination.dots});

  Widget build(BuildContext context, SwiperPluginConfig config) {
    AlignmentGeometry alignment = this.alignment ??
        (config.scrollDirection == Axis.horizontal
            ? Alignment.bottomCenter
            : Alignment.centerRight);

    return new Align(
      key: key,
      alignment: alignment,
      child: new Container(
        margin: margin,
        child: this.builder.build(context, config),
      ),
    );
  }
}

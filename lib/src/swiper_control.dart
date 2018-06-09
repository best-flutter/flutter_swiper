import 'package:flutter/material.dart';
import 'swiper_plugin.dart';

class SwiperControl extends SwiperPlugin {
  ///IconData for previous
  final IconData iconPrevious;

  ///iconData fopr next
  final IconData iconNext;

  ///icon size
  final double size;

  ///Icon normal color, The theme's [ThemeData.primaryColor] by default.
  final Color color;

  ///if set loop=false on Swiper, this color will be used when swiper goto the last slide.
  ///The theme's [ThemeData.disabledColor] by default.
  final Color disableColor;

  final EdgeInsetsGeometry padding;

  final Key key;

  const SwiperControl(
      {this.iconPrevious: Icons.arrow_back_ios,
      this.iconNext: Icons.arrow_forward_ios,
      this.color,
      this.disableColor,
      this.key,
      this.size: 30.0,
      this.padding: const EdgeInsets.all(5.0)});

  Widget buildButton(SwiperPluginConfig config, Color color, IconData iconDaga,
      int quarterTurns, bool previous) {
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (previous) {
          config.controller.previous(animation: true);
        } else {
          config.controller.next(animation: true);
        }
      },
      child: new Padding(
          padding: padding,
          child: new RotatedBox(
              quarterTurns: quarterTurns,
              child: new Icon(
                iconDaga,
                size: size,
                color: color,
              ))),
    );
  }

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);

    Color color = this.color ?? themeData.primaryColor;
    Color disableColor = this.disableColor ?? themeData.disabledColor;
    Color prevColor;
    Color nextColor;

    if (config.loop) {
      prevColor = nextColor = color;
    } else {
      bool next = config.activeIndex < config.itemCount - 2;
      bool prev = config.activeIndex > 0;
      prevColor = prev ? color : disableColor;
      nextColor = next ? color : disableColor;
    }

    if (config.scrollDirection == Axis.horizontal) {
      return new Row(
        key: key,
        children: <Widget>[
          buildButton(config, prevColor, iconPrevious, null, true),
          buildButton(config, nextColor, iconNext, null, false)
        ],
      );
    } else {
      return new Column(
        key: key,
        children: <Widget>[
          buildButton(config, prevColor, iconPrevious, -3, true),
          buildButton(config, nextColor, iconNext, -3, false)
        ],
      );
    }

//    return config.scrollDirection == Axis.horizontal
//        ? new Row(
//            key: key,
//            children: <Widget>[
//              new Expanded(
//                  child: new Align(
//                      alignment: Alignment.centerLeft,
//                      child: new GestureDetector(
//                        behavior: HitTestBehavior.opaque,
//                        onTap: () {
//                          config.controller.previous(animation: true);
//                        },
//                        child: new Padding(
//                            padding: padding,
//                            child: new Icon(
//                              iconPrevious,
//                              size: size,
//                              color: prevColor,
//                            )),
//                      ))),
//              new Expanded(
//                  child: new Align(
//                      alignment: Alignment.centerRight,
//                      child: new GestureDetector(
//                        behavior: HitTestBehavior.opaque,
//                        onTap: () {
//                          config.controller.next(animation: true);
//                        },
//                        child: new Padding(
//                            padding: padding,
//                            child: new Icon(
//                              iconNext,
//                              size: size,
//                              color: nextColor,
//                            )),
//                      )))
//            ],
//          )
//        : new Column(
//            key: key,
//            children: <Widget>[
//              new Expanded(
//                  child: new Align(
//                      alignment: Alignment.topCenter,
//                      child: new GestureDetector(
//                        behavior: HitTestBehavior.opaque,
//                        onTap: () {
//                          config.controller.previous(animation: true);
//                        },
//                        child: new Padding(
//                            padding: padding,
//                            child: new RotatedBox(
//                                quarterTurns: -3,
//                                child: new Icon(
//                                  iconPrevious,
//                                  size: size,
//                                  color: prevColor,
//                                ))),
//                      ))),
//              new Expanded(
//                  child: new Align(
//                      alignment: Alignment.bottomCenter,
//                      child: new GestureDetector(
//                          behavior: HitTestBehavior.opaque,
//                          onTap: () {
//                            config.controller.next(animation: true);
//                          },
//                          child: new Padding(
//                              padding: padding,
//                              child: new RotatedBox(
//                                quarterTurns: -3,
//                                child: new Icon(
//                                  iconNext,
//                                  size: size,
//                                  color: nextColor,
//                                ),
//                              )))))
//            ],
//          );
  }
}

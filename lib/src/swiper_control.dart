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

  const SwiperControl(
      {this.iconPrevious: Icons.arrow_back_ios,
      this.iconNext: Icons.arrow_forward_ios,
      this.color,
      this.disableColor,
      this.size: 30.0,
      this.padding: const EdgeInsets.all(5.0)});

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

    return config.scrollDirection == Axis.horizontal
        ? new Row(
            children: <Widget>[
              new Expanded(
                  child: new Align(
                      alignment: Alignment.centerLeft,
                      child: new InkWell(
                        onTap: () {
                          config.controller.previous(animation: true);
                        },
                        child: new Padding(
                            padding: padding,
                            child: new Icon(
                              iconPrevious,
                              size: size,
                              color: prevColor,
                            )),
                      ))),
              new Expanded(
                  child: new Align(
                      alignment: Alignment.centerRight,
                      child: new InkWell(
                        onTap: () {
                          config.controller.next(animation: true);
                        },
                        child: new Padding(
                            padding: padding,
                            child: new Icon(
                              iconNext,
                              size: size,
                              color: nextColor,
                            )),
                      )))
            ],
          )
        : new Column(
            children: <Widget>[
              new Expanded(
                  child: new Align(
                      alignment: Alignment.topCenter,
                      child: new InkWell(
                        onTap: () {
                          config.controller.previous(animation: true);
                        },
                        child: new Padding(
                            padding: padding,
                            child: new RotatedBox(
                                quarterTurns: -3,
                                child: new Icon(
                                  iconPrevious,
                                  size: size,
                                  color: prevColor,
                                ))),
                      ))),
              new Expanded(
                  child: new Align(
                      alignment: Alignment.bottomCenter,
                      child: new InkWell(
                          onTap: () {
                            config.controller.next(animation: true);
                          },
                          child: new Padding(
                              padding: padding,
                              child: new RotatedBox(
                                quarterTurns: -3,
                                child: new Icon(
                                  iconNext,
                                  size: size,
                                  color: nextColor,
                                ),
                              )))))
            ],
          );
  }
}

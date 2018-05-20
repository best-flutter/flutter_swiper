import 'package:flutter/material.dart';
import 'swiper_plugin.dart';

class SwiperControl extends SwiperPlugin<Widget> {
  final IconData iconPrevious;
  final IconData iconNext;
  final double size;
  final Color activeColor;
  final Color disableColor;
  SwiperControl(
      {this.iconPrevious: Icons.arrow_back_ios,
      this.iconNext: Icons.arrow_forward_ios,
      this.activeColor: Colors.blueAccent,
      this.disableColor: Colors.black12,
      this.size: 30.0});

  @override
  Widget build(SwiperPluginConfig config) {
    return config.axis == Axis.horizontal
        ? new Row(
            children: <Widget>[
              new Expanded(
                  child: new Align(
                      alignment: Alignment.centerLeft,
                      child: new InkWell(
                        onTap: () {
                          config.controller.previous(animation: true);
                        },
                        child: new Icon(
                          iconPrevious,
                          size: size,
                          color: activeColor,
                        ),
                      ))),
              new Expanded(
                  child: new Align(
                      alignment: Alignment.centerRight,
                      child: new InkWell(
                        onTap: () {
                          config.controller.next(animation: true);
                        },
                        child: new Icon(
                          iconNext,
                          size: size,
                          color: activeColor,
                        ),
                      )))
            ],
          )
        : new Column(
            children: <Widget>[],
          );
  }
}

//â€º
//

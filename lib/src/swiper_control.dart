import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperControl extends SwiperPlugin {
  ///IconData for previous
  final IconData iconPrevious;

  ///iconData fopr next
  final IconData iconNext;

  ///icon size
  final double size;

  ///Icon normal color, The theme's [ThemeData.primaryColor] by default.
  final Color? color;

  ///if set loop=false on Swiper, this color will be used when swiper goto the last slide.
  ///The theme's [ThemeData.disabledColor] by default.
  final Color? disableColor;

  final EdgeInsetsGeometry padding;

  final Key? key;

  const SwiperControl({
    this.iconPrevious = Icons.arrow_back_ios,
    this.iconNext = Icons.arrow_forward_ios,
    this.color,
    this.disableColor,
    this.key,
    this.size = 30.0,
    this.padding = const EdgeInsets.all(5.0),
  });

  Widget buildButton({
    required SwiperPluginConfig? config,
    required Color color,
    required IconData iconDaga,
    required int quarterTurns,
    required bool previous,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (previous) {
          config!.controller.previous(animation: true);
        } else {
          config!.controller.next(animation: true);
        }
      },
      child: Padding(
          padding: padding,
          child: RotatedBox(
              quarterTurns: quarterTurns,
              child: Icon(
                iconDaga,
                semanticLabel: previous ? 'Previous' : 'Next',
                size: size,
                color: color,
              ))),
    );
  }

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    final themeData = Theme.of(context);

    final color = this.color ?? themeData.primaryColor;
    final disableColor = this.disableColor ?? themeData.disabledColor;
    Color prevColor;
    Color nextColor;

    if (config.loop) {
      prevColor = nextColor = color;
    } else {
      final next = config.activeIndex < config.itemCount - 1;
      final prev = config.activeIndex > 0;
      prevColor = prev ? color : disableColor;
      nextColor = next ? color : disableColor;
    }

    Widget child;
    if (config.scrollDirection == Axis.horizontal) {
      child = Row(
        key: key,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton(
            config: config,
            color: prevColor,
            iconDaga: iconPrevious,
            quarterTurns: 0,
            previous: true,
          ),
          buildButton(
            config: config,
            color: nextColor,
            iconDaga: iconNext,
            quarterTurns: 0,
            previous: false,
          )
        ],
      );
    } else {
      child = Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton(
            config: config,
            color: prevColor,
            iconDaga: iconPrevious,
            quarterTurns: -3,
            previous: true,
          ),
          buildButton(
            config: config,
            color: nextColor,
            iconDaga: iconNext,
            quarterTurns: -3,
            previous: false,
          )
        ],
      );
    }

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}

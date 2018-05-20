import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import 'package:infinity_page_view/infinity_page_view.dart';
import 'swiper_pagination.dart';
import 'swiper_control.dart';
import 'swiper_controller.dart';
import 'swiper_plugin.dart';

typedef void SwiperOnTap(int index);

class Swiper extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  final ValueChanged<int> onIndexChanged;

  /**
   * auto play config
   */
  final bool autoplay;

  /**
   * Delay between auto play transitions (in millisecond).
   */
  final int autoplayDely;

  /**
   * disable auto play when interaction
   */
  final bool autoplayDiableOnInteraction;

  /**
   * reverse direction
   */
  final bool reverse;

  /**
   * auto play transition duration (in millisecond)
   */
  final int duration;

  /**
   *
   * horizontal/vertical
   *
   */
  final Axis axis;

  /**
   * transition curve
   */
  final Curve curve;

  /**
   * Set to false to disable continuous loop mode.
   */
  final bool loop;
  /**
   *
   *  Index number of initial slide.
   */
  final int index;

  /**
   * Called when tap
   */
  final SwiperOnTap onTap;

  /**
   *The swiper pagination plugin
   */
  final SwiperPagination pagination;

  /**
   * the swiper control button plugin
   */
  final SwiperControl control;

  Swiper(
      {@required this.itemBuilder,
      @required this.itemCount,
      this.autoplay: false,
      this.autoplayDely: 3000,
      this.reverse: false,
      this.autoplayDiableOnInteraction: true,
      this.duration: 300,
      this.onIndexChanged,
      this.index: 0,
      this.onTap,
      this.control,
      this.loop: true,
      this.curve: Curves.ease,
      this.axis: Axis.horizontal,
      this.pagination});

  @override
  State<StatefulWidget> createState() {
    return new _SwiperState();
  }
}

class _SwiperState extends State<Swiper> with SingleTickerProviderStateMixin {
  InfinityPageController pageController;
  SwiperController controller;

  Widget _wrapInkWell(BuildContext context, int index) {
    return new InkWell(
      onTap: () {
        this.widget.onTap(index);
      },
      child: widget.itemBuilder(context, index),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_onController);

    super.dispose();
  }

  @override
  void initState() {
    pageController = new InfinityPageController(initialPage: widget.index);
    _activeIndex = widget.index;
    controller = new SwiperController(widget.index);
    controller.addListener(_onController);
    super.initState();
  }

  void _onController() {
    if (!controller.animation) {
      pageController.jumpToPage(controller.index);
    } else {
      pageController.animateToPage(controller.index,
          duration: new Duration(milliseconds: widget.duration),
          curve: widget.curve);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  int _activeIndex;

  void _onPageChage(int index) {
    controller.index = index;

    setState(() {
      _activeIndex = index;
    });

    if (widget.onIndexChanged != null) {
      widget.onIndexChanged(index);
    }
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification.depth != 0) return false;
//   implement in next version
//    if (notification is ScrollUpdateNotification) {
//      print("update");
//    } else if (notification is ScrollEndNotification) {
//      print("end");
//    } else if (notification is ScrollStartNotification) {
//      print("start");
//    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    IndexedWidgetBuilder itemBuilder =
        widget.onTap == null ? widget.itemBuilder : _wrapInkWell;

    InfinityPageView infinityPageView = new InfinityPageView(
      key: const Key("swiper_bg"),
      itemBuilder: itemBuilder,
      itemCount: widget.itemCount,
      controller: pageController,
      onPageChanged: _onPageChage,
    );

    List<Widget> list = [
      new NotificationListener<ScrollNotification>(
        child: infinityPageView,
        onNotification: _handleNotification,
      )
    ];

    SwiperPluginConfig config;
    // pagination ?
    if (widget.pagination != null) {
      config = ensureConfig(config);
      list.add(createPluginView(widget.pagination, config));
    }

    //controll?
    if (widget.control != null) {
      config = ensureConfig(config);
      list.add(createPluginView(widget.control, config));
    }

    return new Stack(children: list);
  }

  SwiperPluginConfig ensureConfig(SwiperPluginConfig config) {
    if (config == null) {
      config = new SwiperPluginConfig(
          itemCount: widget.itemCount,
          activeIndex: _activeIndex,
          axis: widget.axis,
          controller: controller);
    }
    return config;
  }

  Widget createPluginView(SwiperPlugin plugin, SwiperPluginConfig config) {
    return new SwiperPluginView(plugin, config);
  }
}

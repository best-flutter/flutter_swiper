import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:infinity_page_view/infinity_page_view.dart';
import 'swiper_controller.dart';
import 'swiper_plugin.dart';

import 'dart:async';

typedef void SwiperOnTap(int index);

typedef Widget SwiperDataBuilder(BuildContext context, dynamic data, int index);

class Swiper extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  final ValueChanged<int> onIndexChanged;

  ///auto play config
  final bool autoplay;

  ///Delay between auto play transitions (in millisecond).
  final int autoplayDely;

  ///disable auto play when interaction
  final bool autoplayDiableOnInteraction;

  ///reverse direction
  final bool reverse;

  ///auto play transition duration (in millisecond)
  final int duration;

  ///horizontal/vertical
  final Axis scrollDirection;

  ///transition curve
  final Curve curve;

  /// Set to false to disable continuous loop mode.
  final bool loop;
  ///Index number of initial slide.
  final int index;

  ///Called when tap
  final SwiperOnTap onTap;

  ///The swiper pagination plugin
  final SwiperPlugin pagination;

  ///the swiper control button plugin
  final SwiperPlugin control;

  ///other plugins, you can cutom your own plugin
  final List<SwiperPlugin> plugins;

  final SwiperController controller;

  final ScrollPhysics physics;

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
      this.scrollDirection: Axis.horizontal,
      this.pagination,
      this.plugins,
      this.physics,
      Key key,
      SwiperController controller})
      : controller =
            controller == null ? new SwiperController(index) : controller,
        super(key: key);

  factory Swiper.children(
      {List<Widget> children,
      bool autoplay: false,
      int autoplayDely: 3000,
      bool reverse: false,
      bool autoplayDiableOnInteraction: true,
      int duration: 300,
      ValueChanged<int> onIndexChanged,
      int index: 0,
      SwiperOnTap onTap,
      bool loop: true,
      Curve curve: Curves.ease,
      Axis scrollDirection: Axis.horizontal,
      SwiperPlugin pagination,
      SwiperPlugin control,
      List<SwiperPlugin> plugins,
      SwiperController conttoller,
      Key key,
      ScrollPhysics physics}) {

    assert(children!=null,"children must not be null");



    return new Swiper(
        autoplay: autoplay,
        autoplayDely: autoplayDely,
        autoplayDiableOnInteraction: autoplayDiableOnInteraction,
        reverse: reverse,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: conttoller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        key: key,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
        itemCount: children.length);
  }

  factory Swiper.list(
      {List list,
      SwiperDataBuilder builder,
      bool autoplay: false,
      int autoplayDely: 3000,
      bool reverse: false,
      bool autoplayDiableOnInteraction: true,
      int duration: 300,
      ValueChanged<int> onIndexChanged,
      int index: 0,
      SwiperOnTap onTap,
      bool loop: true,
      Curve curve: Curves.ease,
      Axis scrollDirection: Axis.horizontal,
      SwiperPlugin pagination,
      SwiperPlugin control,
      List<SwiperPlugin> plugins,
      SwiperController conttoller,
      Key key,
      ScrollPhysics physics}) {

    return new Swiper(
        autoplay: autoplay,
        autoplayDely: autoplayDely,
        autoplayDiableOnInteraction: autoplayDiableOnInteraction,
        reverse: reverse,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        key: key,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: conttoller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        itemBuilder: (BuildContext context, int index) {
          return builder(context, list[index], index);
        },
        itemCount: list.length);
  }

  @override
  State<StatefulWidget> createState() {
    return new _SwiperState();
  }
}

class _SwiperState extends State<Swiper> with SingleTickerProviderStateMixin {
  _ControllerAdapger _pageController;
  SwiperController _controller;
  Timer _timer;
  int _activeIndex;

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
    _controller.removeListener(_onController);
    _stopAutoplay();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = createController();
    _controller = widget.controller;
    _controller.addListener(_onController);
    super.initState();
  }

  void _onController() {
    switch (_controller.event) {
      case SwiperControllerEvent.INDEX:
        {
          //print("${new DateTime.now()} _onController ${_controller.index} ");

          if (!_controller.animation) {
            _pageController.jumpToPage(_controller.index);
          } else {
            _pageController.animateToPage(_controller.index,
                duration: new Duration(milliseconds: widget.duration),
                curve: widget.curve);
          }
        }
        break;
      case SwiperControllerEvent.AUTOPLAY:
        {
          _handleAutoplay();
        }
        break;
    }
  }

  @override
  void didChangeDependencies() {
    _updateValues();
    super.didChangeDependencies();
  }

  void _updateValues() {
    _activeIndex = widget.index;
    _controller.autoplay = widget.autoplay;
    _handleAutoplay();
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    if (_controller != widget.controller) {
      _controller.removeListener(_onController);
      _controller = widget.controller;
      _controller.addListener(_onController);
    }

    _pageController = createController();
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  _ControllerAdapger createController() {
    if (widget.loop) {
      return new _InfinityPageControllerAdapter(
          new InfinityPageController(initialPage: widget.index));
    } else {
      return new _PageControllerAdapter(
          new PageController(initialPage: widget.index), widget.itemCount);
    }
  }

  void _handleAutoplay() {
    _stopAutoplay();
    if (_controller.autoplay) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    assert(_timer == null, "Timer must be stopped before start!");
    _timer = new Timer.periodic(
        new Duration(milliseconds: widget.autoplayDely), _onTimer);
  }

  void _onTimer(Timer timer) {
    if (_controller != null) _controller.next(animation: true);
  }

  void _stopAutoplay() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void _onPageChage(int index) {
    _controller.index = index;
    if(_activeIndex == index){
      setState(() {
        _activeIndex = index;
      });
    }
    if (widget.onIndexChanged != null) {
      widget.onIndexChanged(index);
    }
  }

  bool _isHumanDrag;

  bool _handleNotification(ScrollNotification notification) {
    if (notification.depth != 0) return false;
    if (notification is ScrollUpdateNotification) {
      //print("update");
    } else if (notification is ScrollEndNotification) {
      //print("end");
      if (_isHumanDrag && widget.autoplayDiableOnInteraction) {
        _handleAutoplay();
      }
    } else if (notification is ScrollStartNotification) {
      //print("start");
      _isHumanDrag = notification.dragDetails != null;
      if (_isHumanDrag && widget.autoplayDiableOnInteraction) {
        _stopAutoplay();
      }
    }

    return false;
  }

  final Key _scrollViewKey = const Key("swiper_scroll_view");

  Widget createPageView(
      BuildContext context, IndexedWidgetBuilder itemBuilder) {
    if (widget.loop) {
      InfinityPageView infinityPageView = new InfinityPageView(
        key: _scrollViewKey,
        reverse: widget.reverse,
        itemBuilder: itemBuilder,
        itemCount: widget.itemCount,
        controller: _pageController.controller,
        scrollDirection: widget.scrollDirection,
        onPageChanged: _onPageChage,
        physics: widget.physics,
      );
      return infinityPageView;
    } else {
      PageView view = new PageView.builder(
        key: _scrollViewKey,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        controller: _pageController.controller,
        physics: widget.physics,
        onPageChanged: _onPageChage,
        itemBuilder: itemBuilder,
        itemCount: widget.itemCount,
      );
      return view;
    }
  }

  @override
  Widget build(BuildContext context) {
    IndexedWidgetBuilder itemBuilder =
        widget.onTap == null ? widget.itemBuilder : _wrapInkWell;

    List<Widget> list = [];

    if (widget.itemCount > 0) {
      list.add(new NotificationListener<ScrollNotification>(
        child: createPageView(context, itemBuilder),
        onNotification: _handleNotification,
      ));
    }

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

    if (widget.plugins != null) {
      config = ensureConfig(config);
      for (SwiperPlugin plugin in widget.plugins) {
        list.add(createPluginView(plugin, config));
      }
    }

    return new Stack(children: list);
  }

  SwiperPluginConfig ensureConfig(SwiperPluginConfig config) {
    if (config == null) {
      config = new SwiperPluginConfig(
          itemCount: widget.itemCount,
          activeIndex: _activeIndex,
          scrollDirection: widget.scrollDirection,
          controller: _controller);
    }
    return config;
  }

  Widget createPluginView(SwiperPlugin plugin, SwiperPluginConfig config) {
    return new SwiperPluginView(plugin, config);
  }
}

abstract class _ControllerAdapger<T> {
  final T _controller;

  T get controller => _controller;

  const _ControllerAdapger(T controller)
      : assert(controller != null),
        _controller = controller;

  void jumpToPage(int value);

  Future<Null> animateToPage(int value, {Duration duration, Curve curve});
}

class _PageControllerAdapter extends _ControllerAdapger<PageController> {
  final int itemCount;

  _PageControllerAdapter(PageController controller, this.itemCount)
      : super(controller);

  int _ensureIndex(int value) {
    int length = itemCount;
    if (length == 0) return 0;
    value = value % length;
    if (value < 0) {
      value = length - 1;
    }
    return value;
  }

  @override
  Future<Null> animateToPage(int value,
      {Duration duration, Curve curve}) async {
    return await _controller.animateToPage(_ensureIndex(value),
        duration: duration, curve: curve);
  }

  @override
  void jumpToPage(int value) {
    _controller.jumpToPage(_ensureIndex(value));
  }
}

class _InfinityPageControllerAdapter
    extends _ControllerAdapger<InfinityPageController> {
  _InfinityPageControllerAdapter(InfinityPageController controller)
      : super(controller);

  @override
  Future<Null> animateToPage(int value,
      {Duration duration, Curve curve}) async {
    return await _controller.animateToPage(value,
        duration: duration, curve: curve);
  }

  @override
  void jumpToPage(int value) {
    _controller.jumpToPage(value);
  }
}

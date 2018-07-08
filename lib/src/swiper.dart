import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

typedef void SwiperOnTap(int index);

typedef Widget SwiperDataBuilder(BuildContext context, dynamic data, int index);

/// default auto play delay
const int kDefaultAutoplayDelayMs = 3000;

///  Default auto play transition duration (in millisecond)
const int kDefaultAutopayTransactionDuration = 300;

const int kMaxValue = 2000000000;
const int kMiddleValue = 1000000000;

enum SwiperLayout { DEFAULT, STACK, TINDER }

class Swiper extends StatefulWidget {
  /// If set true , the pagination will display 'outer' of the 'content' container.
  final bool outer;

  /// Inner item height, this property is valid if layout=STACK,
  final double itemHeight;

  /// Inner item width, this property is valid if layout=STACK,
  final double itemWidth;

  // height of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double containerHeight;
  // width of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double containerWidth;

  /// Build item on index
  final IndexedWidgetBuilder itemBuilder;

  /// count of the display items
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
  ///If not set , the `Swiper` is 'uncontrolled',whitch means manage index by itself
  ///If set , the `Swiper` is 'controlled',whitch means the index is fully managed by parent widget.
  final int index;

  ///Called when tap
  final SwiperOnTap onTap;

  ///The swiper pagination plugin
  final SwiperPlugin pagination;

  ///the swiper control button plugin
  final SwiperPlugin control;

  ///other plugins, you can cutom your own plugin
  final List<SwiperPlugin> plugins;

  /// decoration of inner swiper
  final BoxDecoration decoration;

  ///
  final SwiperController controller;

  final ScrollPhysics physics;

  ///
  final double viewportFraction;

  ///
  final SwiperLayout layout;
  // This value is valid when viewportFraction is set and < 1.0
  final double scale;

  Swiper({
    @required this.itemBuilder,
    @required this.itemCount,
    this.autoplay: false,
    this.decoration,
    this.layout,
    this.autoplayDely: kDefaultAutoplayDelayMs,
    this.reverse: false,
    this.autoplayDiableOnInteraction: true,
    this.duration: kDefaultAutopayTransactionDuration,
    this.onIndexChanged,
    this.index,
    this.onTap,
    this.control,
    this.loop: true,
    this.curve: Curves.ease,
    this.scrollDirection: Axis.horizontal,
    this.pagination,
    this.plugins,
    this.physics,
    Key key,
    this.controller,

    /// since v1.0.0
    this.containerHeight,
    this.containerWidth,
    this.viewportFraction: 1.0,
    this.itemHeight,
    this.itemWidth,
    this.outer: false,
    this.scale: 1.0,
  }) : super(key: key);

  factory Swiper.children({
    List<Widget> children,
    bool autoplay: false,
    int autoplayDely: kDefaultAutoplayDelayMs,
    bool reverse: false,
    bool autoplayDiableOnInteraction: true,
    int duration: kDefaultAutopayTransactionDuration,
    ValueChanged<int> onIndexChanged,
    int index,
    SwiperOnTap onTap,
    bool loop: true,
    Curve curve: Curves.ease,
    Axis scrollDirection: Axis.horizontal,
    SwiperPlugin pagination,
    SwiperPlugin control,
    List<SwiperPlugin> plugins,
    SwiperController conttoller,
    Key key,
    ScrollPhysics physics,
    double containerHeight,
    double containerWidth,
    double viewportFraction: 1.0,
    double itemHeight,
    double itemWidth,
    bool outer: false,
    double scale: 1.0,
  }) {
    assert(children != null, "children must not be null");

    return Swiper(
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
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

  factory Swiper.list({
    List list,
    SwiperDataBuilder builder,
    bool autoplay: false,
    int autoplayDely: kDefaultAutoplayDelayMs,
    bool reverse: false,
    bool autoplayDiableOnInteraction: true,
    int duration: kDefaultAutopayTransactionDuration,
    ValueChanged<int> onIndexChanged,
    int index,
    SwiperOnTap onTap,
    bool loop: true,
    Curve curve: Curves.ease,
    Axis scrollDirection: Axis.horizontal,
    SwiperPlugin pagination,
    SwiperPlugin control,
    List<SwiperPlugin> plugins,
    SwiperController conttoller,
    Key key,
    ScrollPhysics physics,
    double containerHeight,
    double containerWidth,
    double viewportFraction: 1.0,
    double itemHeight,
    double itemWidth,
    bool outer: false,
    double scale: 1.0,
  }) {
    return Swiper(
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
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
    return _SwiperState();
  }
}

abstract class _SwiperTimerMixin extends State<Swiper> {
  Timer _timer;

  SwiperController _controller;

  @override
  void initState() {
    _controller = widget.controller;
    if (_controller == null) {
      _controller = new SwiperController();
    }
    _controller.addListener(_onController);
    _handleAutoplay();
    super.initState();
  }

  void _onController() {
    switch (_controller.event) {
      case SwiperControllerEvent.START_AUTOPLAY:
        {
          if (_timer == null) {
            _startAutoplay();
          }
        }
        break;
      case SwiperControllerEvent.STOP_AUTOPLAY:
        {
          if (_timer != null) {
            _stopAutoplay();
          }
        }
        break;
      case SwiperControllerEvent.MOVE_INDEX:
      case SwiperControllerEvent.PREV_INDEX:
      case SwiperControllerEvent.NEXT_INDEX:
        break;
    }
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    if (_controller != oldWidget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller.removeListener(_onController);
        _controller = oldWidget.controller;
        _controller.addListener(_onController);
      }
    }
    _handleAutoplay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.removeListener(_onController);
      _controller.dispose();
    }

    _stopAutoplay();
    super.dispose();
  }

  bool _isAutoplay() {
    return _controller.autoplay ?? widget.autoplay;
  }

  void _handleAutoplay() {
    _stopAutoplay();
    if (_isAutoplay()) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    assert(_timer == null, "Timer must be stopped before start!");
    _timer =
        Timer.periodic(Duration(milliseconds: widget.autoplayDely), _onTimer);
  }

  void _onTimer(Timer timer) {
    _controller.next(animation: true);
  }

  void _stopAutoplay() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}

class _SwiperState extends _SwiperTimerMixin {
  int _activeIndex;

  Widget _wrapTap(BuildContext context, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        this.widget.onTap(index);
      },
      child: widget.itemBuilder(context, index),
    );
  }

  @override
  void initState() {
    _activeIndex = widget.index ?? 0;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    if (widget.index != null && widget.index != _activeIndex) {
      _activeIndex = widget.index;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onIndexChanged(int index) {
    setState(() {
      _activeIndex = index;
    });
    if (widget.onIndexChanged != null) {
      widget.onIndexChanged(index);
    }
  }

  Widget _buildSwiper() {
    IndexedWidgetBuilder itemBuilder;
    if (widget.onTap != null) {
      itemBuilder = _wrapTap;
    } else {
      itemBuilder = widget.itemBuilder;
    }

    if (widget.layout == SwiperLayout.STACK) {
      return new _StackSwiper(
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
      );
    } else if (widget.layout == null || widget.layout == SwiperLayout.DEFAULT) {
      return new _PageViewSwiper(
        containerWidth: widget.containerWidth,
        containerHeight: widget.containerHeight,
        viewportFraction: widget.viewportFraction,
        scale: widget.scale,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        scrollDirection: widget.scrollDirection,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        physics: widget.physics,
      );
    } else if (widget.layout == SwiperLayout.TINDER) {
      return new _TinderSwiper(
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
      );
    } else {
      return new Container();
    }
  }

  SwiperPluginConfig _ensureConfig(SwiperPluginConfig config) {
    if (config == null) {
      config = SwiperPluginConfig(
          outer: widget.outer,
          itemCount: widget.itemCount,
          activeIndex: _activeIndex,
          scrollDirection: widget.scrollDirection,
          controller: _controller,
          loop: widget.loop);
    }
    return config;
  }

  List<Widget> _ensureListForStack(
      Widget swiper, List<Widget> listForStack, Widget widget) {
    if (listForStack == null) {
      listForStack = [swiper, widget];
    } else {
      listForStack.add(widget);
    }
    return listForStack;
  }

  @override
  Widget build(BuildContext context) {
    Widget swiper = _buildSwiper();
    List<Widget> listForStack;
    SwiperPluginConfig config;
    if (widget.control != null) {
      //Stack
      config = _ensureConfig(config);
      listForStack = _ensureListForStack(
          swiper, listForStack, widget.control.build(context, config));
    }

    if (widget.plugins != null) {
      config = _ensureConfig(config);
      for (SwiperPlugin plugin in widget.plugins) {
        listForStack = _ensureListForStack(
            swiper, listForStack, plugin.build(context, config));
      }
    }
    if (widget.pagination != null) {
      config = _ensureConfig(config);
      if (widget.outer) {
        return _buildOuterPagination(
            widget.pagination,
            listForStack == null ? swiper : new Stack(children: listForStack),
            config);
      } else {
        listForStack = _ensureListForStack(
            swiper, listForStack, widget.pagination.build(context, config));
      }
    }

    if (listForStack != null) {
      return new Stack(
        children: listForStack,
      );
    }

    return swiper;
  }

  Widget _buildOuterPagination(
      SwiperPagination pagination, Widget swiper, SwiperPluginConfig config) {
    List<Widget> list = [];
    //Only support bottom yet!
    if (widget.containerHeight != null || widget.containerWidth != null) {
      list.add(swiper);
    } else {
      list.add(new Expanded(child: swiper));
    }

    list.add(new Align(
      alignment: Alignment.center,
      child: pagination.build(context, config),
    ));

    return new Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
    );
  }
}

abstract class _SubSwiper extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int index;
  final ValueChanged<int> onIndexChanged;
  final SwiperController controller;
  final int duration;
  final Curve curve;
  final double itemWidth;
  final double itemHeight;

  _SubSwiper(
      {Key key,
      this.itemHeight,
      this.itemWidth,
      this.duration,
      this.curve,
      this.itemBuilder,
      this.controller,
      this.index,
      this.itemCount,
      this.onIndexChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState();

  int getCorrectIndex(int indexNeedsFix) {
    if (itemCount == 0) return 0;
    int value = indexNeedsFix % itemCount;
    if (value < 0) {
      value += itemCount;
    }
    return value;
  }
}

class _TinderSwiper extends _SubSwiper {
  _TinderSwiper(
      {Key key,
      Curve curve,
      int duration,
      SwiperController controller,
      ValueChanged<int> onIndexChanged,
      double itemHeight,
      double itemWidth,
      IndexedWidgetBuilder itemBuilder,
      int index,
      int itemCount})
      : assert(itemWidth != null && itemHeight != null),  super(
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount);

  @override
  State<StatefulWidget> createState() {
    return _TinderState();
  }
}

class _StackSwiper extends _SubSwiper {
  _StackSwiper(
      {Key key,
      Curve curve,
      int duration,
      SwiperController controller,
      ValueChanged<int> onIndexChanged,
      double itemHeight,
      double itemWidth,
      IndexedWidgetBuilder itemBuilder,
      int index,
      int itemCount})
      : super(
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount);

  @override
  State<StatefulWidget> createState() {
    return _StackViewState();
  }
}

class _PageViewSwiper extends _SubSwiper {
  final double scale;
  final double viewportFraction;
  final ScrollPhysics physics;
  final double containerWidth;
  final double containerHeight;
  final Axis scrollDirection;

  _PageViewSwiper(
      {this.scale,
      this.physics,
      this.scrollDirection,
      this.viewportFraction,
      ValueChanged<int> onIndexChanged,
      Key key,
      this.containerWidth,
      this.containerHeight,
      IndexedWidgetBuilder itemBuilder,
      Curve curve,
      int duration,
      int index,
      int itemCount,
      SwiperController controller})
      : super(
            key: key,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            onIndexChanged: onIndexChanged,
            index: index,
            itemCount: itemCount);

  @override
  State<StatefulWidget> createState() {
    return _PageViewState();
  }
}

class _TinderState extends _CustomLayoutStateBase<_TinderSwiper> {
  List<double> scales;
  List<double> offsetsX;
  List<double> offsetsY;
  List<double> opacity;
  List<double> rotates;

  double getOffsetY(double scale){
    return widget.itemHeight - widget.itemHeight * scale;
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startIndex = -3;
    _animationCount = 5;
    opacity = [0.0, 0.9, 0.9, 1.0, 0.0, 0.0];
    scales = [0.80, 0.80, 0.85, 0.90, 1.0, 1.0, 1.0];
    offsetsX = [
      0.0,
      0.0,
      0.0,
      0.0,
      _screenWidth,
      _screenWidth
    ];
    offsetsY = [
      0.0,
      0.0,
      -5.0,
      -10.0,
      -15.0,
      -20.0,
    ];
    rotates = [0.0, 0.0, 0.0, 0.0, 20.0, 25.0];
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsetsX, animationValue, i);
    double fy = _getValue(offsetsY, animationValue, i);
    double o = _getValue(opacity, animationValue, i);
    double a = _getValue(rotates, animationValue, i);

    return new Center(
      child:  new Opacity(
          opacity: o,
          child: new Transform.rotate(
            angle: a / 180.0,
            child: new Transform.translate(
              key: new ValueKey<int>(_currentIndex + i),
              offset: new Offset(f, fy),
              child: new Transform.scale(
                scale: s,
                alignment: Alignment.bottomCenter,
                child: new SizedBox(
                  width: widget.itemWidth ?? double.infinity,
                  height: widget.itemHeight ?? double.infinity,
                  child: widget.itemBuilder(context, realIndex),
                ),
              ),
            ),
          ),
        ),
    );
  }
}

class _StackViewState extends _CustomLayoutStateBase<_StackSwiper> {
  List<double> scales;
  List<double> offsets;
  List<double> opacity;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    double space = (_screenWidth - widget.itemWidth) / 2;

    //length of the values array below
    _animationCount = 5;

    //Array below this line, '0' index is 1.0 ,witch is the first item show in swiper.
    _startIndex = -3;
    scales = [0.7, 0.8, 0.9, 1.0, 1.0];
    offsets = [0.0, space / 3, space / 3 * 2, space, _screenWidth];
    opacity = [0.0, 0.5, 1.0, 1.0, 1.0];
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsets, animationValue, i);
    double o = _getValue(opacity, animationValue, i);

    return new Opacity(
      opacity: o,
      child: new Transform.translate(
        key: new ValueKey<int>(_currentIndex + i),
        offset: new Offset(f, 0.0),
        child: new Transform.scale(
          scale: s,
          alignment: Alignment.centerLeft,
          child: new SizedBox(
            width: widget.itemWidth ?? double.infinity,
            height: widget.itemHeight ?? double.infinity,
            child: widget.itemBuilder(context, realIndex),
          ),
        ),
      ),
    );
  }
}

abstract class _CustomLayoutStateBase<T extends _SubSwiper> extends State<T>
    with SingleTickerProviderStateMixin {
  double _screenWidth;
  Animation<double> _animation;
  AnimationController _animationController;
  int _startIndex;
  int _animationCount;

  @override
  void initState() {
    if (widget.itemWidth == null) {
      throw new Exception(
          "==============\n\nwidget.itemWith must not be null when use stack layout.\n========\n");
    }

    _createAnimationController();
    widget.controller.addListener(_onController);
    super.initState();
  }

  void _createAnimationController() {
    _animationController = new AnimationController(vsync: this, value: 0.5);
    Tween<double> tween = new Tween(begin: 0.0, end: 1.0);
    _animation = tween.animate(_animationController);
  }

  @override
  void didChangeDependencies() {
    _screenWidth = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onController);
      widget.controller.addListener(_onController);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onController);
    _animationController?.dispose();
    super.dispose();
  }

  double _getValue(List<double> values, double animationValue, int index) {
    double s = values[index];
    if (animationValue >= 0.5) {
      if (index < values.length - 1) {
        s = s + (values[index + 1] - s) * (animationValue - 0.5) * 2.0;
      }
    } else {
      if (index != 0) {
        s = s - (s - values[index - 1]) * (0.5 - animationValue) * 2.0;
      }
    }
    return s;
  }

  Widget _buildItem(int i, int realIndex, double animationValue);

  Widget _buildContainer(List<Widget> list) {
    return new Stack(
      children: list,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget w) {
    List<Widget> list = [];

    double animationValue = _animation.value;

    for (int i = 0; i < _animationCount; ++i) {
      int realIndex = _currentIndex + i + _startIndex;
      realIndex = realIndex % widget.itemCount;
      if (realIndex < 0) {
        realIndex += widget.itemCount;
      }

      list.add(_buildItem(i, realIndex, animationValue));
    }

    return new GestureDetector(
      onPanStart: _onPanStart,
      onPanEnd: _onPanEnd,
      onPanUpdate: _onPanUpdate,
      child: _buildContainer(list),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: _animationController, builder: _buildAnimation);
  }

  double _currentValue;
  double _currentPos;
  void _onPanUpdate(DragUpdateDetails details) {
    if (_lockScroll) return;
    _animationController.value = _currentValue +
        (details.globalPosition.dx - _currentPos) / _screenWidth / 2;
  }

  bool _lockScroll = false;

  void _move(double position, {int nextIndex}) async {
    if (_lockScroll) return;
    try {
      _lockScroll = true;
      await _animationController.animateTo(position,
          duration: new Duration(milliseconds: widget.duration),
          curve: widget.curve);
      if (nextIndex != null) {
        widget.onIndexChanged(widget.getCorrectIndex(nextIndex));
      }
    } catch (e) {
      print(e);
    } finally {
      if (nextIndex != null) {
        try {
          _animationController.value = 0.5;
        } catch (e) {
          print(e);
        }

        _currentIndex = nextIndex;
      }
      _lockScroll = false;
    }
  }

  void _onController() {
    switch (widget.controller.event) {
      case SwiperControllerEvent.PREV_INDEX:
        _move(1.0, nextIndex: _currentIndex - 1);
        break;
      case SwiperControllerEvent.NEXT_INDEX:
        _move(0.0, nextIndex: _currentIndex + 1);
        break;
      case SwiperControllerEvent.MOVE_INDEX:
        throw new Exception(
            "Not support SwiperControllerEvent.MOVE_INDEX  yet!");
      case SwiperControllerEvent.STOP_AUTOPLAY:
      case SwiperControllerEvent.START_AUTOPLAY:
        break;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_lockScroll) return;
    if (_animationController.value >= 0.75 ||
        details.velocity.pixelsPerSecond.dx > 500.0) {
      _move(1.0, nextIndex: _currentIndex - 1);
    } else if (_animationController.value < 0.25 ||
        details.velocity.pixelsPerSecond.dx < -500.0) {
      _move(0.0, nextIndex: _currentIndex + 1);
    } else {
      _move(0.5);
    }
  }

  void _onPanStart(DragStartDetails details) {
    if (_lockScroll) return;
    _currentValue = _animationController.value;
    _currentPos = details.globalPosition.dx;
  }

  int _currentIndex = 0;
}

class _PageViewState extends State<_PageViewSwiper>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  SwiperController _controller;
  int _activeIndex;

  int _calcIndex(int index) {
    return index - kMiddleValue;
  }

  double _page() {
    if (_pageController.position.maxScrollExtent == null ||
        _pageController.position.minScrollExtent == null) {
      return 0.0;
    }

    return _pageController.page - kMiddleValue;
  }

  int _initPage() {
    return _activeIndex + kMiddleValue;
  }

  int _itemCount() {
    return kMaxValue;
  }

  Widget _buildAnimationItem(BuildContext context, int index) {
    return new AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget w) {
          int newIndex = _calcIndex(index);
          double page = _page();
          double scale = 1.0 -
              widget.curve.transform((page - newIndex).abs().clamp(0.0, 1.0)) *
                  (1.0 - widget.scale);

          int renderIndex = newIndex % widget.itemCount;
          if (renderIndex < 0) {
            renderIndex += widget.itemCount;
          }

          return new Transform.scale(
            scale: scale,
            child: widget.itemBuilder(context, renderIndex),
          );
        });
  }

  @override
  void initState() {
    if (widget.index != null) {
      _activeIndex = widget.index;
    } else {
      _activeIndex = 0;
    }
    _pageController = new PageController(
      initialPage: _initPage(),
      viewportFraction: widget.viewportFraction,
    );

    widget.controller.addListener(_onController);

    super.initState();
  }

  void _move(int nextIndex, bool animation) {
    if (animation) {
      _pageController.animateToPage(nextIndex + kMiddleValue,
          duration: new Duration(milliseconds: widget.duration),
          curve: widget.curve);
    } else {
      _pageController.jumpToPage(nextIndex + kMiddleValue);
    }
  }

  void _onController() {
    switch (widget.controller.event) {
      case SwiperControllerEvent.NEXT_INDEX:
        _move(_activeIndex + 1, widget.controller.animation);
        break;
      case SwiperControllerEvent.PREV_INDEX:
        _move(_activeIndex - 1, widget.controller.animation);
        break;
      case SwiperControllerEvent.MOVE_INDEX:
        _move(widget.controller.index, widget.controller.animation);
        break;
      case SwiperControllerEvent.STOP_AUTOPLAY:
      case SwiperControllerEvent.START_AUTOPLAY:
        break;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onController);
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_PageViewSwiper oldWidget) {
    if (widget.index != null && widget.index != _activeIndex) {
      if (widget.getCorrectIndex(_activeIndex) != widget.index) {
        _activeIndex = widget.index;
      }
    }

    if (widget.viewportFraction != oldWidget.viewportFraction ||
        (widget.index != null && widget.index != _activeIndex)) {
      _pageController = new PageController(
        initialPage: _initPage(),
        viewportFraction: widget.viewportFraction,
      );
    }

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onController);
      widget.controller.addListener(_onController);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return Container();
    }

    IndexedWidgetBuilder itemBuilder;
    if (widget.scale != null) {
      itemBuilder = _buildAnimationItem;
    } else {
      itemBuilder = widget.itemBuilder;
    }

    int itemCount = _itemCount();
    PageView pageView = new PageView.builder(
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      onPageChanged: _onPageChange,
      controller: _pageController,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );

    if (widget.containerWidth != null || widget.containerHeight != null) {
      return new SizedBox(
        width: widget.containerWidth ?? double.infinity,
        height: widget.containerHeight ?? double.infinity,
        child: pageView,
      );
    }

    return pageView;
  }

  void _onPageChange(int index) {
    _activeIndex = index - kMiddleValue;
    widget.onIndexChanged(widget.getCorrectIndex(_activeIndex));
  }
}
